-----------------------------------
-- Area: Cloister of Frost
-- BCNM: Trial by Ice
-----------------------------------
local cloisterOfFrostID = zones[xi.zone.CLOISTER_OF_FROST]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.CLOISTER_OF_FROST,
    battlefieldId    = xi.battlefield.id.TRIAL_BY_ICE,
    canLoseExp       = false,
    maxPlayers       = 6,
    timeLimit        = utils.minutes(30),
    index            = 0,
    entryNpc         = 'IP_Entrance',
    exitNpc          = 'Ice_Protocrystal',
    requiredKeyItems = { xi.ki.TUNING_FORK_OF_ICE },

    questArea = xi.questLog.SANDORIA,
    quest     = xi.quest.id.sandoria.TRIAL_BY_ICE,
})

function content:onEventFinishWin(player, csid, option, npc)
    player:addTitle(xi.title.HEIR_OF_THE_GREAT_ICE)
    npcUtil.giveKeyItem(player, xi.ki.WHISPER_OF_FROST)
end

content.groups =
{
    {
        mobIds =
        {
            { cloisterOfFrostID.mob.SHIVA_PRIME     },
            { cloisterOfFrostID.mob.SHIVA_PRIME + 1 },
            { cloisterOfFrostID.mob.SHIVA_PRIME + 2 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
