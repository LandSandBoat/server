-----------------------------------
--- Area: Talacca Cove
-- Quest: Breaking the Bonds of Fate - Limit Break (COR)
-----------------------------------
local talaccaCoveID = zones[xi.zone.TALACCA_COVE]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId                = xi.zone.TALACCA_COVE,
    battlefieldId         = xi.battlefield.id.BREAKING_THE_BONDS_OF_FATE,
    canLoseExp            = false,
    maxPlayers            = 1,
    levelCap              = xi.settings.main.MAX_LEVEL,
    allowSubjob           = false,
    timeLimit             = utils.minutes(10),
    index                 = 3,
    entryNpc              = '_1l0',
    exitNpcs              = { '_1l1', '_1l2', '_1l3' },
    requiredItems         = { xi.item.CORSAIRS_TESTIMONY, wearMessage = talaccaCoveID.text.TESTIMONY_WEARS, wornMessage = talaccaCoveID.text.TESTIMONY_IS_TORN },
    questArea             = xi.questLog.AHT_URHGAN,
    quest                 = xi.quest.id.ahtUrhgan.BREAKING_THE_BONDS_OF_FATE,
    requiredVar           = 'Quest[6][41]Prog',
    requiredValue         = 1,
})

function content:entryRequirement(player, npc, isRegistrant, trade)
    local jobRequirement   = player:getMainJob() == xi.job.COR
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
            { talaccaCoveID.mob.QULTADA     },
            { talaccaCoveID.mob.QULTADA + 1 },
            { talaccaCoveID.mob.QULTADA + 2 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
