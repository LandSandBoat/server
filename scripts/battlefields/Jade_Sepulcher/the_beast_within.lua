-----------------------------------
-- Area: Jade Sepulcher
-- Quest: The Beast Within - Limit Break (BLU)
-----------------------------------
local jadeSepulcherID = zones[xi.zone.JADE_SEPULCHER]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId                = xi.zone.JADE_SEPULCHER,
    battlefieldId         = xi.battlefield.id.BEAST_WITHIN,
    canLoseExp            = false,
    maxPlayers            = 1,
    levelCap              = xi.settings.main.MAX_LEVEL,
    allowSubjob           = false,
    timeLimit             = utils.minutes(10),
    index                 = 2,
    entryNpc              = '_1v0',
    exitNpcs              = { '_1v1', '_1v2', '_1v3' },
    requiredItems         = { xi.item.BLUE_MAGES_TESTIMONY, wearMessage = jadeSepulcherID.text.TESTIMONY_WEARS, wornMessage = jadeSepulcherID.text.TESTIMONY_IS_TORN },
    questArea             = xi.questLog.AHT_URHGAN,
    quest                 = xi.quest.id.ahtUrhgan.THE_BEAST_WITHIN,
    requiredVar           = 'Quest[6][40]Prog',
    requiredValue         = 2,
})

function content:entryRequirement(player, npc, isRegistrant, trade)
    local jobRequirement   = player:getMainJob() == xi.job.BLU
    local levelRequirement = player:getMainLvl() >= 66

    return jobRequirement and levelRequirement
end

function content:setupBattlefield(battlefield)
    local player      = GetPlayerByID(battlefield:getInitiator())
    local playerLevel = player and player:getMainLvl() or 99

    battlefield:setLocalVar('playerLevel', playerLevel)
end

content.groups =
{
    {
        mobIds =
        {
            { jadeSepulcherID.mob.RAUBAHN     },
            { jadeSepulcherID.mob.RAUBAHN + 1 },
            { jadeSepulcherID.mob.RAUBAHN + 2 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
