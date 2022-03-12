Config = {}

Config.ShowBlips = true

Config.Objects = {
    ["cone"] = {model = `prop_roadcone02a`, freeze = false},
    ["barrier"] = {model = `prop_barrier_work06a`, freeze = true},
    ["roadsign"] = {model = `prop_snow_sign_road_06g`, freeze = true},
    ["tent"] = {model = `prop_gazebo_03`, freeze = true},
    ["light"] = {model = `prop_worklight_03b`, freeze = true},
}

Config.MaxSpikes = 5

Config.HandCuffItem = 'handcuffs'

Config.LicenseRank = 2
Config.Locations = {
    ["duty"] = {
        [1] = vector3(1362.05, -1301.83, 77.77),
    },
    ["stash"] = {
        [1] = vector3(1359.24, -1299.65, 77.76),
    },
    ["armory"] = {
        [1] = vector3(1361.16, -1305.7, 77.76),
    },
    ["evidence"] = {
        [1] = vector3(1361.39, -1303.77, 77.77),
    },
    ["stations"] = {
        [1] = {label = "Sheriff", coords = vector3(1360.88, -1301.53, 77.77)},
    },
}

Config.WeaponHashes = {}

Config.ArmoryWhitelist = {}
Config.WhitelistedVehicles = {}

Config.Items = {
    label = "Police Armory",
    slots = 30,
    items = {
        {
            name = "weapon_revolver_cattleman",
            price = 0,
            amount = 1,
            info = {
                serie = "",
            },
            type = "weapon",
            slot = 1,
            authorizedJobGrades = {0, 1, 2, 3, 4}
        },
        {
            name = "weapon_repeater_winchester",
            price = 0,
            amount = 1,
            info = {
                serie = "",
            },
            type = "weapon",
            slot = 2,
            authorizedJobGrades = {0, 1, 2, 3, 4}
        },
        {
            name = "weapon_melee_lantern",
            price = 0,
            amount = 1,
            info = {},
            type = "weapon",
            slot = 3,
            authorizedJobGrades = {0, 1, 2, 3, 4}
        },
        {
            name = "weapon_lasso",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 4,
            authorizedJobGrades = {0, 1, 2, 3, 4}
        },
        {
            name = "ammo_revolver",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 5,
            authorizedJobGrades = {0, 1, 2, 3, 4}
        },
        {
            name = "ammo_repeater",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 6,
            authorizedJobGrades = {0, 1, 2, 3, 4}
        },
    }
}