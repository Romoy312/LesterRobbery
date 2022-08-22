Config = {}


Config.RequiredItems = { --Not in use
    "thermite",
    "advancedlockpick"
}

Config.Chance = 25 --Not in use

Config.TruckItems = { --Items that will be in the trunk of the vehicle spawned
    [1] = {
        name = "laptop_red",
        amount = 1,
        info = {},
        type = "item",
        slot = 1,
    },
    [2] = {
        name = "usb_red",
        amount = 3,
        info = {},
        type = "item",
        slot = 2,
    },
    [3] = {
        name = "thermite",
        amount = 7,
        info = {},
        type = "item",
        slot = 3,
    },
    [4] = {
        name = "boostinglaptop",
        amount = 2,
        info = {},
        type = "item",
        slot = 4,
    },
    [5] = {
        name = "boostingdisabler",
        amount = 1,
        info = {},
        type = "item",
        slot = 5,
    },
}

Config.Spot = { --Not in use either
    ['LesterStorage'] = {
        label = 'Lesters Warehouse',
        type = 'warehouse',
        coords = vector3(707.45904, -966.9133, 30.412843),
        hacked = false,
        policeClose = false,
        object = 245182344, 681066206,
        heading = {
            closed = 250.0,
            open = 160.0
        },
        laptop = vector4(717.85205, -975.7183, 24.910398, 4.5432543),
    }
}

Config.Distance = 1.5 --Max Distance player can be from laptop to do the hack

Config.Models = {
    laptopmodel = 1385417869,  --Model of the object used 
    backdoormodel = 1518466392,
}
Config.MinPolice = 0 --Not in use at the moment, future update

Config.CoolDown = 1000000/60000 --Time displayed in notify message, don't touch the number after the '/'
Config.Cooling = 1000000 --Amount of time hack is on cooldown
Config.Fuel = 'lj-fuel' --Change to whatever fuel systenm you use

Config.Locations = { --Locations that vehicle can spawn
    vector4(-580.9742, -1119.274, 22.178577, 84.29058),
    vector4(-682.0448, -878.4678, 24.499057, 180.86965),
    vector4(-1018.592, -1007.149, 2.1032044, 115.95909),
    vector4(-1163.437, -2055.085, 14.145155, 324.11349),
    vector4(-767.6372, -2602.057, 13.84762, 232.90646),
    vector4(866.77465, -3020.203, 5.8709816, 272.15036),
    vector4(1638.7873, -2275.123, 106.16671, 4.5649113),
    vector4(1306.4942, -1749.682, 53.878448, 22.562105),
    vector4(755.53625, -306.0304, 59.881511, 301.2843),
    vector4(808.15509, 1272.6915, 360.48495, 264.75378),
    vector4(118.9, -1069.41, 28.72, 359.57)
}
