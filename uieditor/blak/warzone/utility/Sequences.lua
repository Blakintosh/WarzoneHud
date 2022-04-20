Util.ClipSequence = function(parent, self, identifier, sequences)
    if not parent.__sequences then
        parent.__sequences = {}
    end

    if not parent.__sequences[identifier] then
        parent.__sequences[identifier] = {}
    end

    table.insert(parent.__sequences[identifier], {
        widget = self,
        sequences = sequences
    })
end

Util.CopySequence = function(parent, source, target, previousIdentifier, identifier)
	if not parent.__sequences or not parent.__sequences[previousIdentifier] then
		Console.PrintError("Parent has no sequences or no sequences with the specified identifier "..previousIdentifier)
		return
	end

	for k, v in ipairs(parent.__sequences[previousIdentifier]) do
		if v.widget == source then
			Util.ClipSequence(parent, target, identifier, v.sequences)
			return
		end
	end
	Console.PrintError("Unable to find a sequence for widget "..(source.id or "(no ID)").." using identifier "..previousIdentifier)
end

-- Ricochet on deez nuts
local function FindInitialValuesForProperty(lastSequence, property)
    for k, v in pairs(lastSequence) do
        if k == property then
            return v
        end
    end
end

Util.GetTweenedProgress = function(progress, startv, endv)
    return (startv + ((endv - startv) * progress))
end

Util.AnimateNextSegment = function(parent, self, event, sequenceData, lastSequence, sequenceTable, index, repeatCount, extraData)
    if event.interrupted or not sequenceTable[index] then
        sequenceData.clipsRemaining = sequenceData.clipsRemaining - 1

        if sequenceData.clipsRemaining == 0 and extraData.looping then
            parent.nextClip = extraData.clipName or "DefaultClip"
        end

        parent.clipFinished(self, {})
        return
    end

    local sequence = sequenceTable[index]
	local duration = sequence.duration
	if type(duration) == "function" then
		duration = duration()
	end

    if sequence.repeat_start == true then
        Util.AnimateNextSegment(parent, self, {}, sequenceData, lastSequence, sequenceTable, index + 1, sequence.repeat_count, extraData)
    elseif sequence.repeat_end == true then
        repeatCount = repeatCount - 1
        local goingTo = index
        if repeatCount > 0 then
            for i = index, 1, -1 do
                if sequenceTable[i].repeat_start == true then
                    goingTo = i
                    break
                end
            end
        end
        Util.AnimateNextSegment(parent, self, {}, sequenceData, lastSequence, sequenceTable, goingTo + 1, repeatCount, extraData)
    else
        if duration > 0 then
            local tweenType = Util.TweenGraphs.linear
            if sequence.interpolation then
                tweenType = sequence.interpolation
            end

            Util.Tween.interpolate(self, duration, tweenType, function(progress)
                -- Iterate through the sequence table to interpolate to desired values
                for k,value in pairs(sequence) do
                    if k ~= "interpolation" and k ~= "duration" and k ~= "exec" and type(value) ~= "function" then
                        -- find the value this property had before this sequence started
                        local lastValue = FindInitialValuesForProperty(lastSequence, k)
                        -- we don't want to interpolate anything except numbers (and numbers in tables...)
                        if type(value) == "number" then
                            -- exec this property function, with the tweened progress
                            local newVal = Util.GetTweenedProgress(progress, lastValue, value)
                            self[k](self, newVal)
                        elseif type(value) == "table" then
                            local progressTable = {}
                            -- iterate thru the table and get progress by sending it to a working table
                            for key,val in ipairs(lastValue) do
                                -- apparently I can't just copy the table as it's passed by reference, so let's do this?
                                if type(val) == "number" then
                                    progressTable[key] = Util.GetTweenedProgress(progress, lastValue[key], value[key])
                                else
                                    progressTable[key] = value[key]
                                end
                            end
                            self[k](self, unpack(progressTable))
                        end
                    end
                end
            end)
            for k,value in pairs(sequence) do
                if k == "exec" then
                    value()
                elseif type(value) == "function" and k ~= "interpolation" and k ~= "duration" then
                    self[k](self, value())
                end
            end
        else
            for k,value in pairs(sequence) do
                if k ~= "interpolation" and k ~= "duration" and k ~= "exec" then
                    if type(value) == "function" then
                        self[k](self, value())
                    elseif type(value) ~= "table" then
                        self[k](self, value)
                    else
                        self[k](self, unpack(value))
                    end
                elseif k == "exec" then
                    value()
                end
            end
        end

        if duration > 0 then
            self:registerEventHandler("tween_complete", function(self, event)
                Util.AnimateNextSegment(parent, self, event, sequenceData, sequence, sequenceTable, index + 1, repeatCount, extraData)
            end)
        else
            Util.AnimateNextSegment(parent, self, {}, sequenceData, sequence, sequenceTable, index + 1, repeatCount, extraData)
        end
    end
end

Util.AnimateSequence = function(self, identifier, extraData)
    if not self.__sequences or not self.__sequences[identifier] then
        return
    end

    extraData = extraData or {}

    local SequenceData = {
        clipsTotal = #self.__sequences[identifier],
        clipsRemaining = #self.__sequences[identifier]
    }

    self:setupElementClipCounter(SequenceData.clipsTotal)
    
    -- Iterate through all ELEMENTS
    for k,v in ipairs(self.__sequences[identifier]) do
        v.widget:completeAnimation()

        local sequence = v.sequences[1]
		local duration = sequence.duration
		if type(duration) == "function" then
			duration = duration()
		end
        if sequence.repeat_start == true then
            Util.AnimateNextSegment(self, v.widget, {}, SequenceData, {}, v.sequences, 2, sequence.repeat_count, extraData)
        else
            if duration > 0 then
                error("Bad Sequence code. Script needs a 0 duration initial clip to get start values.")
            end

            for k,value in pairs(sequence) do
                if k ~= "interpolation" and k ~= "duration" and k ~= "exec" then
                    if type(value) == "function" then
                        v.widget[k](v.widget, value())
                    elseif type(value) ~= "table" then
                        v.widget[k](v.widget, value)
                    elseif type(value) == "table" then
                        v.widget[k](v.widget, unpack(value))
                    end
                elseif k == "exec" then
                    value()
                end
            end

            if duration > 0 then
                error("Bad Sequence Code.")
                v.widget:registerEventHandler("tween_complete", function(widget, event)
                    Util.AnimateNextSegment(self, v.widget, event, SequenceData, sequence, v.sequences, 2, 0, extraData)
                end)
            else
                Util.AnimateNextSegment(self, v.widget, {}, SequenceData, sequence, v.sequences, 2, 0, extraData)
            end
        end
    end
end