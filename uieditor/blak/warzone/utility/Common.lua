Wzu.Colors = {
    Black = { r = 0, g = 0, b = 0 },
    White = { r = 1, g = 1, b = 1 },
    FreshMango = { r = 0.9961, g = 0.6667, b = 0.2902 },
    Malibu = { r = 0.2902, g = 0.7804, b = 0.9961 },
    GreenYellow = { r = 0.6902, g = 0.9961, b = 0.2902 },
    Player4Color = { r = 0.7098, g = 0.3686, b = 1 },
    Grey63 = { r = 0.2471, g = 0.2471, b = 0.2471 },
    WeatheredSlate = { r = 0.8902, g = 0.9098, b = 0.8863 },
    BRPlunderGreen = { r = 0.7686, g = 0.8118, b = 0.7137 },
    Grey191 = { r = 0.7490, g = 0.7490, b = 0.7490 },
    AlertOrange = { r = 0.7451, g = 0.3137, b = 0.1647 },
    Rarities = {
        { r = 0.4549, g = 0.4549, b = 0.4549 }, -- Misc
        { r = 0.9490, g = 0.0784, b = 0.0784 }, -- Common
        { r = 0.9490, g = 0.5922, b = 0.0784 }, -- Uncommon
        { r = 0.1412, g = 0.9098, b = 0.1961 }, -- Epic
        { r = 0.3098, g = 0.6118, b = 0.8941 }, -- Legendary
        { r = 0.1882, g = 0.2980, b = 0.9608 }, -- Ultra
        { r = 0.7451, g = 0.1686, b = 0.9608 } -- Packed
    },
    Asphalt = { r = 0.1333, g = 0.1451, b = 0.1569},
    CodeLightBlue = { r = 0.3372, g = 0.6902, b = 0.9294 },
    ArenaRedDark = { r = 0.5294, g = 0.2549, b = 0.2549 },
    ArenaRedLight = { r = 0.7373, g = 0.3608, b = 0.3608 },
    Watermelon = { r = 1, g = 0.3412, b = 0.3412 },
    lightBlue = { r = 0.1059, g = 0.8627, b = 1},
    PowerupOrange = { r = 0.9961, g = 0.7608, b = 0.0902}
}

Wzu.Swatches = {
    Players = {Wzu.Colors.FreshMango, Wzu.Colors.Malibu, Wzu.Colors.GreenYellow, Wzu.Colors.Player4Color},
    Overcharged = Wzu.Colors.FreshMango,
    HUDShadow = Wzu.Colors.Grey63,
    HUDMain = Wzu.Colors.WeatheredSlate,
    HUDWarning = Wzu.Colors.AlertOrange,
    Cash = Wzu.Colors.BRPlunderGreen,
    GlobalKeyColor = Wzu.Colors.CodeLightBlue,
    BackgroundDisabled = Wzu.Colors.Asphalt,
    EnemyTeam = Wzu.Colors.Watermelon,
    FriendlyTeam = Wzu.Colors.CodeLightBlue,
    FriendlyTeamTextHighlight = Wzu.Colors.lightBlue,
}

Wzu.Fonts = {
    MainRegular = "fonts/main_regular.ttf",
    MainBold = "fonts/main_bold.ttf",
    KillstreakRegular = "fonts/killstreak_regular.ttf",
    BattlenetBold = "fonts/notosans_semicondensedbold.ttf"
}

Wzu.Sounds = {
    Countdowns = {
        MatchEnd = {
            Low = "ui_mp_timer_countdown_matchend_5_1",
            Near = "ui_mp_timer_countdown_matchend_10_6",
            General = "ui_mp_timer_countdown_matchend"
        },
        MatchStart = {
            Low = "ui_mp_timer_countdown_matchstart_3_1",
            Near = "ui_mp_timer_countdown_matchstart_8_4",
            General = "ui_mp_timer_countdown_matchstart"
        }
    },
    Grenades = {
        RestockLethal = "iw8_ui_restock_lethals",
        RestockTactical = "iw8_ui_restock_tacticals"
    }
}

Wzu.SetRGBFromTable = function(self, color)
    self:setRGB(color.r, color.g, color.b)
end

Wzu.ConvertColorToTable = function(color)
    return {color.r, color.g, color.b}
end

Wzu.GetClientColor = function(clientNum)
    return Wzu.Swatches.Players[clientNum + 1]
end