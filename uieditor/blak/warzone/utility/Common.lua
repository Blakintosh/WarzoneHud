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
    Asphalt = { r = 0.1333, g = 0.1451, b = 0.1569},
    CodeLightBlue = { r = 0.3372, g = 0.6902, b = 0.9294 },
    ArenaRedDark = { r = 0.5294, g = 0.2549, b = 0.2549 },
    ArenaRedLight = { r = 0.7373, g = 0.3608, b = 0.3608 },
    Watermelon = { r = 1, g = 0.3412, b = 0.3412 },
    lightBlue = { r = 0.1059, g = 0.8627, b = 1},
    PowerupOrange = { r = 0.9961, g = 0.7608, b = 0.0902},
    BlakintoshPurple = { r = 0.3059, g = 0, b = 1 },
    MustardGreen = { r = 0.6588, g = 0.7098, b = 0.0157 },
    ChelseaCucumber = { r = 0.4824, g = 0.6588, b = 0.3098 },
    PictonBlue = { r = 0.4039, g = 0.5804, b = 0.8078 },
    Deluge = { r = 0.7569, g = 0.4118, b = 0.9490 },
    EpicOrange = { r = 0.9569, g = 0.4824, b = 0.07059 },
    VibrantRed = { r = 0.93333, g = 0.2471, b = 0.1373 },
    RocketRedDark = { r = 0.6627, g = 0.2471, b = 0.1725 },
    ModernGreen = { r = 0.5490, g = 0.7745, b = 0.4275 },
    TidePool = { r = 0.3490, g = 0.4745, b = 0.5216 },
    CodeBlueSelected = { r = 0.4745, g = 0.8510, b = 1 },
    Ash = { r = 0.2824, g = 0.3294, b = 0.3333 },
    Grey17 = { r = 0.0667, g = 0.0667, b = 0.0667 },
    SmoothBlue = { r = 0.6078, g = 0.6667, b = 0.7020 },
    Grey56 = { r = 0.2196, g = 0.2196, b = 0.2196 }
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
    Rarities = {
        Wzu.Colors.Grey63, --Misc
        Wzu.Colors.MustardGreen, --Common
        Wzu.Colors.ChelseaCucumber, --Uncommon
        Wzu.Colors.PictonBlue, --Rare
        Wzu.Colors.Deluge, --Epic
        Wzu.Colors.EpicOrange, --Legendary
        Wzu.Colors.VibrantRed, --Ultra
        Wzu.Colors.BlakintoshPurple, --Packed
    },
    WeaponMeterWorse = Wzu.Colors.RocketRedDark,
    WeaponMeterBetter = Wzu.Colors.ModernGreen,
    MenuTitle = Wzu.Colors.TidePool,
    MenuFrame = Wzu.Colors.CodeLightBlue,
    MenuBorder = Wzu.Colors.Ash,
    ButtonTextDefault = Wzu.Colors.TidePool,
    ButtonTextFocus = Wzu.Colors.CodeLightBlue, --CodeBlueSelected
    ButtonBackground = Wzu.Colors.Grey17, 
    ButtonBackgroundFocus = Wzu.Colors.CodeLightBlue,
    ButtonBorder = Wzu.Colors.Grey56,
    TextPrimaryText = Wzu.Colors.WeatheredSlate
}

Wzu.Fonts = {
    MainRegular = "fonts/main_regular.ttf",
    MainBold = "fonts/main_bold.ttf",
    MainLight = "fonts/main_light.ttf",
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

Wzu.CursorTypes = {
    Normal = RegisterImage("ui_cursor_arrow_normal"),
    Active = RegisterImage("ui_cursor_arrow_active"),
    Input = RegisterImage("ui_cursor_i_beam"),
    Rotate = RegisterImage("ui_cursor_arrow_rotation"),
    Translate = RegisterImage("ui_cursor_arrow_panfourways"),
    Contextual = RegisterImage("ui_cursor_arrow_contextual")
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