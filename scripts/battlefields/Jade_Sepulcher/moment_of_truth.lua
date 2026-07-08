-----------------------------------
-- Area: Jade Sepulcher
-- Quest: The Beast Within - Limit Break (BLU)
-----------------------------------
local jadeSepulcherID = zones[xi.zone.JADE_SEPULCHER]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId        = xi.zone.JADE_SEPULCHER,
    battlefieldId = xi.battlefield.id.MOMENT_OF_TRUTH,
    maxPlayers    = 6,
    timeLimit     = utils.minutes(30),
    index         = 3,
    entryNpc      = '_1v0',
    exitNpcs      = { '_1v1', '_1v2', '_1v3' },
    questArea     = xi.questLog.AHT_URHGAN,
    quest         = xi.quest.id.ahtUrhgan.MOMENT_OF_TRUTH,
    requiredVar   = 'Quest[6][30]Prog',
    requiredValue = 4,
})

content.groups =
{
    {
        mobIds =
        {
            {
                jadeSepulcherID.mob.SHADOWHAND_KAJEEL_JA,
                jadeSepulcherID.mob.SHADOWHAND_KAJEEL_JA + 1,
                jadeSepulcherID.mob.SHADOWHAND_KAJEEL_JA + 2,
                jadeSepulcherID.mob.SHADOWHAND_KAJEEL_JA + 3,
                jadeSepulcherID.mob.SHADOWHAND_KAJEEL_JA + 4,
                jadeSepulcherID.mob.SHADOWHAND_KAJEEL_JA + 5
            },

            {
                jadeSepulcherID.mob.SHADOWHAND_KAJEEL_JA + 6,
                jadeSepulcherID.mob.SHADOWHAND_KAJEEL_JA + 7,
                jadeSepulcherID.mob.SHADOWHAND_KAJEEL_JA + 8,
                jadeSepulcherID.mob.SHADOWHAND_KAJEEL_JA + 9,
                jadeSepulcherID.mob.SHADOWHAND_KAJEEL_JA + 10,
                jadeSepulcherID.mob.SHADOWHAND_KAJEEL_JA + 11
            },

            {
                jadeSepulcherID.mob.SHADOWHAND_KAJEEL_JA + 12,
                jadeSepulcherID.mob.SHADOWHAND_KAJEEL_JA + 13,
                jadeSepulcherID.mob.SHADOWHAND_KAJEEL_JA + 14,
                jadeSepulcherID.mob.SHADOWHAND_KAJEEL_JA + 15,
                jadeSepulcherID.mob.SHADOWHAND_KAJEEL_JA + 16,
                jadeSepulcherID.mob.SHADOWHAND_KAJEEL_JA + 17
            },

        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
