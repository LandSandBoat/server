-----------------------------------
-- Area: Qu'Bia Arena
-- Name: Shattering Stars - Maat Fight (BRD)
-----------------------------------
local qubiaID = zones[xi.zone.QUBIA_ARENA]
-----------------------------------

local content = Battlefield:new({
    zoneId        = xi.zone.QUBIA_ARENA,
    battlefieldId = xi.battlefield.id.SHATTERING_STARS_BRD,
    maxPlayers    = 1,
    levelCap      = 99,
    allowSubjob   = false,
    timeLimit     = utils.minutes(10),
    index         = 7,
    entryNpc      = 'BC_Entrance',
    exitNpc       = 'Burning_Circle',
    requiredItems = { xi.item.BARDS_TESTIMONY, wearMessage = qubiaID.text.TESTIMONY_WEARS, wornMessage = qubiaID.text.TESTIMONY_IS_TORN },
})

function content:entryRequirement(player, npc, isRegistrant, trade)
    return player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.SHATTERING_STARS) >= xi.questStatus.QUEST_ACCEPTED and
        player:getMainJob() == xi.job.BRD and
        player:getMainLvl() >= 66
end

content.groups =
{
    {
        mobIds =
        {
            { qubiaID.mob.MAAT + 6 },
            { qubiaID.mob.MAAT + 7 },
            { qubiaID.mob.MAAT + 8 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
