Config = {}

Config.SafeModel = {}

Config.RequiredItems = {
    "thermite",
    "advancedlockpick"
}

Config.TruckItems = {
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
}

Config.Spot = {
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

Config.Distance = 1.5

Config.Models = {
    laptopmodel = 1385417869
}
Config.MinPolice = 0

Config.Rewards = {
    chance = 35, 
    Items = {
    "laptop_red",
    "usb_red",
    "boostinglaptop",
    "boostingdisabler",
    }
}

Config.CoolDown = 1000000/60000
Config.Cooling = 10000

Config.Locations = {
    Spawn = {
     {x = 46.21846,  y = -1.123022, z = 69.52243,   h = 255.15000},
     {x = 788.25756, y = -997.9289, z =  26.070653, h =5.8936314},
     {x = -420.1586, y = -1168.821, z =  20.797712, h =183.47119},
    },
} 