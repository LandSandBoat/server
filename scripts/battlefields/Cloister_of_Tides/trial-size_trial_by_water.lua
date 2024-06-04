-----------------------------------
-- Area: Cloister of Tides
-- BCNM: Trial-size Trial by Water
-----------------------------------
local cloisterOfTidesID = zones[xi.zone.CLOISTER_OF_TIDES]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.CLOISTER_OF_TIDES,
    battlefieldId    = xi.battlefield.id.TRIAL_SIZE_TRIAL_BY_WATER,
    canLoseExp       = false,
    maxPlayers       = 1,
    levelCap         = 20,
    timeLimit        = utils.minutes(15),
    index            = 1,
    entryNpc         = 'WP_Entrance',
    exitNpc          = 'Water_Protocrystal',
    requiredItems    = { xi.item.MINI_TUNING_FORK_OF_WATER },

    questArea = xi.questLog.OUTLANDS,
    quest     = xi.quest.id.outlands.TRIAL_SIZE_TRIAL_BY_WATER,
})

function content:entryRequirement(player, npc, isRegistrant, trade)
    return player:getMainJob() == xi.job.SMN and
        player:getMainLvl() >= 20
end

function content:onEventFinishWin(player, csid, option, npc)
    if not player:hasSpell(xi.magic.spell.LEVIATHAN) then
        player:addSpell(xi.magic.spell.LEVIATHAN)
        player:messageSpecial(cloisterOfTidesID.text.LEVIATHAN_UNLOCKED, 0, 0, 2)
    end

    if not player:hasItem(xi.item.SCROLL_OF_INSTANT_WARP) then
        npcUtil.giveItem(player, xi.item.SCROLL_OF_INSTANT_WARP)
    end

    player:addFame(xi.fameArea.NORG, 30)
    player:completeQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.TRIAL_SIZE_TRIAL_BY_WATER)
end

content.groups =
{
    {
        mobIds =
        {
            { cloisterOfTidesID.mob.LEVIATHAN_PRIME + 3 },
            { cloisterOfTidesID.mob.LEVIATHAN_PRIME + 4 },
            { cloisterOfTidesID.mob.LEVIATHAN_PRIME + 5 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
