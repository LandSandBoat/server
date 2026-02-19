-----------------------------------
-- Fire in the Sky
-- Level 40 ENM
-- !addkeyitem 674
-----------------------------------
local monarchLinnID = zones[xi.zone.MONARCH_LINN]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.MONARCH_LINN,
    battlefieldId    = xi.battlefield.id.FIRE_IN_THE_SKY,
    maxPlayers       = 18,
    levelCap         = 40,
    timeLimit        = utils.minutes(15),
    index            = 2,
    entryNpc         = 'SD_Entrance',
    exitNpcs         = { 'SD_BCNM_Exit_1', 'SD_BCNM_Exit_2', 'SD_BCNM_Exit_3' },
    requiredKeyItems = { xi.ki.MONARCH_BEARD, message = monarchLinnID.text.TORN_FROM_YOUR_HANDS },
    grantXP = 2500,
})

content.groups =
{
    {
        mobs = { 'Razon' },

        allDeath = function(battlefield, mob)
           -- If Razon dies from self-destruct, everyone gets kicked out anyway, but this keeps the chest from spawning.
            if battlefield:getLocalVar('phase') < 4 then
                content:handleAllMonstersDefeated(battlefield, mob)
            end
        end,
    },
}

content.loot =
{
    {
        { itemId = xi.item.NONE,              weight = 9500 },
        { itemId = xi.item.CLOUD_EVOKER,      weight = 1500 },
    },

    {
        { itemId = xi.item.NONE,              weight = 5000 },
        { itemId = xi.item.THUGS_ZAMBURAK,    weight = 2500 },
        { itemId = xi.item.HORROR_VOULGE,     weight = 2500 },
    },

    {
        { itemId = xi.item.NONE,              weight = 3500 },
        { itemId = xi.item.CROSSBOWMANS_RING, weight = 2000 },
        { itemId = xi.item.WOODSMAN_RING,     weight = 1500 },
        { itemId = xi.item.ETHER_RING,        weight = 3000 },
    },
}
return content:register()
