-----------------------------------
-- Area: Horlais Peak
-- Name: Shattering stars - Maat Fight (RNG)
-----------------------------------
local horlaisID = zones[xi.zone.HORLAIS_PEAK]
-----------------------------------

local content = Battlefield:new({
    zoneId        = xi.zone.HORLAIS_PEAK,
    battlefieldId = xi.battlefield.id.SHATTERING_STARS_RNG,
    maxPlayers    = 1,
    levelCap      = 99,
    allowSubjob   = false,
    timeLimit     = utils.minutes(10),
    index         = 7,
    entryNpc      = 'BC_Entrance',
    exitNpc       = 'Burning_Circle',
    requiredItems = { xi.item.RANGERS_TESTIMONY, wearMessage = horlaisID.text.TESTIMONY_WEARS, wornMessage = horlaisID.text.TESTIMONY_IS_TORN },
})

function content:entryRequirement(player, npc, isRegistrant, trade)
    return player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.SHATTERING_STARS) >= xi.questStatus.QUEST_ACCEPTED and
        player:getMainJob() == xi.job.RNG and
        player:getMainLvl() >= 66
end

content.groups =
{
    {
        mobIds =
        {
            { horlaisID.mob.MAAT + 6 },
            { horlaisID.mob.MAAT + 7 },
            { horlaisID.mob.MAAT + 8 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
