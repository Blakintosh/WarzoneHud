EnableGlobals()
if not Console then
	Console = {}

	Console.Print = function()
	end
	Console.PrintWarning = function()
	end
	Console.PrintInfo = function()
	end
	Console.PrintError = function()
	end
end
DisableGlobals()

Util.Colors = {
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
    CodeBlue = { r = 0.2039, g = 0.3569, b = 0.4706 },
    CodeBlueSelected = { r = 0.4745, g = 0.8510, b = 1 },
    Ash = { r = 0.2824, g = 0.3294, b = 0.3333 },
    Grey17 = { r = 0.0667, g = 0.0667, b = 0.0667 },
    SmoothBlue = { r = 0.6078, g = 0.6667, b = 0.7020 },
    Grey56 = { r = 0.2196, g = 0.2196, b = 0.2196 },
    Pavement = { r = 0.5176, g = 0.5529, b = 0.5059 },
    Grey128 = { r = 0.5020, g = 0.5020, b = 0.5020 },
    DarkPhoshper = { r = 0.1490, g = 0.2275, b = 0.2431 },
    IceIceBaby = { r = 0.8902, g = 0.9529, b = 0.9686 },
    Gold = { r = 0.8863, g = 0.7569, b = 0.0706 },
    VeryDarkBlue = { r = 0.0588, g = 0.05882, b = 0.1451 },
    CodeDarkBlue = { r = 0, g = 0.3020, b = 0.4667 },
    WetPavement = { r = 0.2980, g = 0.3216, b = 0.2824 },
    BlueGrey = { r = 0.3020, g = 0.3843, b = 0.4784 },
    WarmerMedGrey = { r = 0.6471, g = 0.6157, b = 0.5843},
    UnfocusedGrey = { r = 0.4196, g = 0.4235, b = 0.4039 },
	Grey89 = { r = 0.3490, g = 0.3490, b = 0.3490 },
    Perks = {
        ArmorVest = { r = 0.8667, g = 0.1755, b = 0.1755 },
        FastReload = { r = 0.1, g = 0.7157, b = 0.1 },
        Rof = { r = 0.9294, g = 0.7686, b = 0.1451 },
        DoubleTap2 = { r = 0.9294, g = 0.7686, b = 0.1451 },
        QuickRevive = { r = 0.3529, g = 0.8039, b = 0.9725 },
        ExtraAmmo = { r = 0.3020, g = 0.5882, b = 0.9412 },
        VigorVodka = { r = 0.9216, g = 0.2196, b = 0.3255 },
        PhdFlopper = { r = 0.6392, g = 0.1490, b = 0.9412 },
        ShadyShandy = { r = 0.8196, g = 0.2706, b = 0.0784 },
        BulletDamage = { r = 0.9411, g = 0.2275, b = 0.1490 }
    }
}

Util.Swatches = {
    Players = {Util.Colors.FreshMango, Util.Colors.Malibu, Util.Colors.GreenYellow, Util.Colors.Player4Color},
    Overcharged = Util.Colors.FreshMango,
    HUDShadow = Util.Colors.Grey63,
    HUDMain = Util.Colors.WeatheredSlate,
    HUDStable = Util.Colors.IceIceBaby,
    HUDWarning = Util.Colors.AlertOrange,
    HUDWarningDanger = Util.Colors.VibrantRed,
    HUDCaution = Util.Colors.Gold,
    Cash = Util.Colors.BRPlunderGreen,
    GlobalKeyColor = Util.Colors.CodeLightBlue,
    BackgroundDisabled = Util.Colors.Asphalt,
    EnemyTeam = Util.Colors.Watermelon,
    FriendlyTeam = Util.Colors.CodeLightBlue,
    FriendlyTeamDark = Util.Colors.DarkPhoshper,
    FriendlyTeamTextHighlight = Util.Colors.lightBlue,
    Rarities = {
        Util.Colors.Grey63, --Misc
        Util.Colors.MustardGreen, --Common
        Util.Colors.ChelseaCucumber, --Uncommon
        Util.Colors.PictonBlue, --Rare
        Util.Colors.Deluge, --Epic
        Util.Colors.EpicOrange, --Legendary
        Util.Colors.VibrantRed, --Ultra
        Util.Colors.BlakintoshPurple, --Packed
    },
    RaritiesLight = {
        Util.Colors.Grey128, --Misc
        Util.Colors.MustardGreen, --Common
        Util.Colors.ChelseaCucumber, --Uncommon
        Util.Colors.PictonBlue, --Rare
        Util.Colors.Deluge, --Epic
        Util.Colors.EpicOrange, --Legendary
        Util.Colors.VibrantRed, --Ultra
        Util.Colors.BlakintoshPurple, --Packed
    },
    WeaponMeterWorse = Util.Colors.RocketRedDark,
    WeaponMeterBetter = Util.Colors.ModernGreen,
    MenuTitle = Util.Colors.TidePool,
    MenuFrame = Util.Colors.CodeLightBlue,
    MenuBorder = Util.Colors.Ash,
    MenuLocked = Util.Colors.Pavement,
    ButtonTextDefault = Util.Colors.TidePool,
    ButtonTextDefaultGrey = Util.Colors.UnfocusedGrey,
    ButtonTextFocus = Util.Colors.CodeLightBlue,
    ButtonTextDisabled = Util.Colors.Pavement,
    MenuButtonText = Util.Colors.CodeBlueSelected,
    ButtonBackground = Util.Colors.Grey17, 
    ButtonBackgroundFocus = Util.Colors.CodeLightBlue,
    ButtonBackgroundDisabled = Util.Colors.Asphalt,
    ButtonBorder = Util.Colors.Grey56,
    ButtonTextureUnfocused = Util.Colors.Grey128,
    TextPrimaryText = Util.Colors.WeatheredSlate,
    FieldUpgradeIdle = Util.Colors.WeatheredSlate,
    ScoreboardFriendly = Util.Colors.CodeLightBlue,
    FriendlyDarkBlue = Util.Colors.VeryDarkBlue,
    ScoreboardFriendlyTeamDark = Util.Colors.CodeDarkBlue,
    GlobalKeyColorMid = Util.Colors.CodeBlue,
    PlayerTeam = Util.Colors.Gold,
    PopupBackground = Util.Colors.WetPavement,
    PopupFrame = Util.Colors.TidePool,
    PopupBgGradient = Util.Colors.BlueGrey,
    PopupHeaderTxt = Util.Colors.CodeDarkBlue,
    PopupTitleTxt = Util.Colors.TidePool,
    PopupSubHeaderTxt2 = Util.Colors.WarmerMedGrey,
	ScorestreakButtonUnavailable = Util.Colors.Grey89
}

Util.Fonts = {
    MainRegular = "fonts/main_regular.ttf",
    MainBold = "fonts/main_bold.ttf",
    MainLight = "fonts/main_light.ttf",
    KillstreakRegular = "fonts/killstreak_regular.ttf",
    BattlenetBold = "fonts/notosans_semicondensedbold.ttf"
}

Util.Sounds = {
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

Util.CursorTypes = {
    Normal = "ui_cursor_arrow_normal",
    Active = "ui_cursor_arrow_active",
    Input = "ui_cursor_i_beam",
    Rotate = "ui_cursor_arrow_rotation",
    Translate = "ui_cursor_arrow_panfourways",
    Contextual = "ui_cursor_arrow_contextual"
}

Util.SetRGBFromTable = function(self, color)
    self:setRGB(color.r, color.g, color.b)
end

Util.ConvertColorToTable = function(color)
    return {color.r, color.g, color.b}
end

Util.GetClientColor = function(clientNum)
    return Util.Swatches.Players[clientNum + 1]
end

SoundSet.iw8 = {
    action = "iw8_ui_button_select", 
    gain_focus = "", 
    list_action = "iw8_ui_button_select", 
    menu_go_back = "iw8_ui_menu_backout", 
    menu_open = "", 
    menu_pause = "iw8_ui_menu_adjust_screen_deny",
    list_up = "iw8_ui_button_updownmovement", 
    list_down = "iw8_ui_button_updownmovement", 
    list_left = "iw8_ui_button_updownmovement", 
    list_right = "iw8_ui_button_updownmovement", 
    partyease_slide_left = "uin_party_ease_slide", 
    partyease_slide_right = "uin_party_ease_slide_back", 
    toggle = "uin_paint_image_flip_toggle", 
    ekg_1 = "mpl_rejack_ekg_1", 
    ekg_2 = "mpl_rejack_ekg_2", 
    ekg_3 = "mpl_rejack_ekg_3", 
    flatline = "mpl_rejack_flatline", 
    faction_in = "mpl_start_faction_ui_in", 
    faction_out = "mpl_start_faction_ui_out", 
    xp_in = "mpl_start_xp_ui_in", 
    xp_out = "mpl_start_xp_ui_out", 
    obj_in = "mpl_start_show_obj_ui_in", 
    obj_out = "mpl_start_show_obj_ui_out",
    popup_open = "iw8_ui_menu_leavelobby_alert"
}
