-----------------------------------
-- Puppetmaster Blues
-- Talacca Cove, PUP AF3 Battlefield
-- !addkeyitem VALKENGS_MEMORY_CHIP
-- !addkeyitem TOGGLE_SWITCH
-----------------------------------
local ID = zones[xi.zone.TALACCA_COVE]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.TALACCA_COVE,
    battlefieldId    = xi.battlefield.id.PUPPETMASTER_BLUES,
    maxPlayers       = 6,
    levelCap         = 99,
    timeLimit        = utils.minutes(30),
    index            = 2,
    entryNpc         = '_1l0',
    exitNpcs         = { '_1l1', '_1l2', '_1l3' },
    allowTrusts      = true,
    requiredKeyItems = { xi.ki.VALKENGS_MEMORY_CHIP, xi.ki.TOGGLE_SWITCH },
})

content:addEssentialMobs({ 'Valkeng' })

content.loot =
{
    {
        { itemId = xi.item.GIL, weight = xi.loot.weight.NORMAL, amount = 9000 },
    },
}

return content:register()
