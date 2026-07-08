-----------------------------------
-- Follow the White Rabbit
-- Bearclaw Pinnacle ENM, Zephyr Fan
-- !addkeyitem ZEPHYR_FAN
-----------------------------------
local ID = zones[xi.zone.BEARCLAW_PINNACLE]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.BEARCLAW_PINNACLE,
    battlefieldId    = xi.battlefield.id.FOLLOW_THE_WHITE_RABBIT,
    maxPlayers       = 18,
    levelCap         = 75,
    timeLimit        = utils.minutes(30),
    index            = 1,
    entryNpc         = 'Wind_Pillar_2',
    exitNpc          = 'Wind_Pillar_Exit',
    requiredKeyItems = { xi.ki.ZEPHYR_FAN, message = ID.text.ZEPHYR_RIPS },
    grantXP          = 2500,
    armouryCrates    =
    {
        ID.mob.BEARCLAW_RABBIT + 6,
        ID.mob.BEARCLAW_RABBIT + 13,
        ID.mob.BEARCLAW_RABBIT + 21,
    },
})

local function handleDeath(battlefield, mob)
    local baseId = ID.mob.BEARCLAW_RABBIT + (battlefield:getArea() - 1) * 7

    for mobId = baseId, baseId + 5 do
        local rabbit = GetMobByID(mobId)
        if rabbit and rabbit:isAlive() then
            return
        end
    end

    content:handleAllMonstersDefeated(battlefield, mob)
end

content.groups =
{
    {
        -- Bearclaw Rabbit
        mobIds =
        {
            {
                ID.mob.BEARCLAW_RABBIT,
            },

            {
                ID.mob.BEARCLAW_RABBIT + 7,
            },

            {
                ID.mob.BEARCLAW_RABBIT + 14,
            },

        },

        superlinkGroup = 1,
        death = handleDeath,
    },

    {
        -- Bearclaw Leveret
        mobIds =
        {
            {
                ID.mob.BEARCLAW_RABBIT + 1,
                ID.mob.BEARCLAW_RABBIT + 2,
                ID.mob.BEARCLAW_RABBIT + 3,
                ID.mob.BEARCLAW_RABBIT + 4,
                ID.mob.BEARCLAW_RABBIT + 5,
            },

            {
                ID.mob.BEARCLAW_RABBIT + 8,
                ID.mob.BEARCLAW_RABBIT + 9,
                ID.mob.BEARCLAW_RABBIT + 10,
                ID.mob.BEARCLAW_RABBIT + 11,
                ID.mob.BEARCLAW_RABBIT + 12,
            },

            {
                ID.mob.BEARCLAW_RABBIT + 15,
                ID.mob.BEARCLAW_RABBIT + 16,
                ID.mob.BEARCLAW_RABBIT + 17,
                ID.mob.BEARCLAW_RABBIT + 18,
                ID.mob.BEARCLAW_RABBIT + 19,
            },
        },

        superlinkGroup = 1,
        spawned = false,
        death = handleDeath,
    },
}

content.loot =
{
    {
        { itemId = xi.item.NONE,                   weight = 9500 },
        { itemId = xi.item.CLOUD_EVOKER,           weight =  500 },
    },

    {
        { itemId = xi.item.NONE,                   weight = 2500 },
        { itemId = xi.item.SQUARE_OF_GALATEIA,     weight = 2500 },
        { itemId = xi.item.SQUARE_OF_KEJUSU_SATIN, weight = 2500 },
        { itemId = xi.item.POT_OF_VIRIDIAN_URUSHI, weight = 2500 },
    },

    {
        quantity = 2,
        { itemId = xi.item.NONE,                   weight = 5500 },
        { itemId = xi.item.MARTIAL_SWORD,          weight =  800 },
        { itemId = xi.item.SHAMO,                  weight =  800 },
        { itemId = xi.item.VENTURERS_BELT,         weight =  800 },
        { itemId = xi.item.SERENE_RING,            weight =  700 },
        { itemId = xi.item.SCROLL_OF_RAISE_III,    weight = 1400 },
    },
}

return content:register()
