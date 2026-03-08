-----------------------------------
--- Area: Talacca Cove
-- Quest: Puppetmaster Blues - PUP AF3
-----------------------------------
local talaccaCoveID = zones[xi.zone.TALACCA_COVE]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.TALACCA_COVE,
    battlefieldId    = xi.battlefield.id.PUPPETMASTER_BLUES,
    maxPlayers       = 6,
    levelCap         = xi.settings.main.MAX_LEVEL,
    timeLimit        = utils.minutes(30),
    index            = 2,
    entryNpc         = '_1l0',
    exitNpcs         = { '_1l1', '_1l2', '_1l3' },
    questArea        = xi.questLog.AHT_URHGAN,
    quest            = xi.quest.id.ahtUrhgan.PUPPETMASTER_BLUES,
    requiredKeyItems = { xi.ki.TOGGLE_SWITCH, xi.ki.VALKENGS_MEMORY_CHIP },
})

content.groups =
{
    {
        mobIds =
        {
            { talaccaCoveID.mob.VALKENG     },
            { talaccaCoveID.mob.VALKENG + 1 },
            { talaccaCoveID.mob.VALKENG + 2 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
