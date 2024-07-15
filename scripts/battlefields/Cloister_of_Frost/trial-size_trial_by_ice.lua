-----------------------------------
-- Area: Cloister of Frost
-- BCNM: Trial-size Trial by Ice
-----------------------------------
local cloisterOfFrostID = zones[xi.zone.CLOISTER_OF_FROST]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.CLOISTER_OF_FROST,
    battlefieldId    = xi.battlefield.id.TRIAL_SIZE_TRIAL_BY_ICE,
    canLoseExp       = false,
    maxPlayers       = 1,
    levelCap         = 20,
    timeLimit        = utils.minutes(15),
    index            = 2,
    entryNpc         = 'IP_Entrance',
    exitNpc          = 'Ice_Protocrystal',
    requiredItems    = { xi.item.MINI_TUNING_FORK_OF_ICE },

    questArea = xi.questLog.SANDORIA,
    quest     = xi.quest.id.sandoria.TRIAL_SIZE_TRIAL_BY_ICE,
})

function content:entryRequirement(player, npc, isRegistrant, trade)
    return player:getMainJob() == xi.job.SMN and
        player:getMainLvl() >= 20
end

function content:onEventFinishWin(player, csid, option, npc)
    if not player:hasSpell(xi.magic.spell.SHIVA) then
        player:addSpell(xi.magic.spell.SHIVA)
        player:messageSpecial(cloisterOfFrostID.text.SHIVA_UNLOCKED, 0, 0, 4)
    end

    if not player:hasItem(xi.item.SCROLL_OF_INSTANT_WARP) then
        npcUtil.giveItem(player, xi.item.SCROLL_OF_INSTANT_WARP)
    end

    player:addFame(xi.fameArea.SANDORIA, 30)
    player:completeQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.TRIAL_SIZE_TRIAL_BY_ICE)
end

content.groups =
{
    {
        mobIds =
        {
            { cloisterOfFrostID.mob.SHIVA_PRIME + 21 },
            { cloisterOfFrostID.mob.SHIVA_PRIME + 22 },
            { cloisterOfFrostID.mob.SHIVA_PRIME + 23 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
