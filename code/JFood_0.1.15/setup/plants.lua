
plants =
{
    ["wheat"] =
    {
        name = "plant-wheat",
        icons = { "plant_wheat" },
        mining = { { name = "wheat", amount_min = 2, amount_max = 4 } },
        destroy = { { item = "wheat", probability = 1, count_min = 1, count_max = 2 } },
        starting_area = true,
        color = { r = 255, g = 164, b = 0 },
        health = 200,
        settings = {
            size = 2,
            frequency = 400
        },
        order = "JF-ea"
    },
    ["water-melon"] =
    {
        name = "water-melon",
        icons = { "water_melon_plant" },
        mining = { { name = "water-melon", amount_min = 2, amount_max = 8 } },
        destroy = { { item = "water-melon", probability = 1, count_min = 1, count_max = 4 } },
        starting_area = true,
        color = { r = 0, g = 255, b = 255 },
        health = 200,
        settings = {
            size = 1,
            frequency = 200
        },
        order = "JF-eb"
    }
}