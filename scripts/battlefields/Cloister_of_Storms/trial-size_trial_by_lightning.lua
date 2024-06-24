-----------------------------------
-- Area: Cloister of Storms
-- BCNM: Trial-size Trial by Lightning
-----------------------------------
local cloisterOfStormsID = zones[xi.zone.CLOISTER_OF_STORMS]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.CLOISTER_OF_STORMS,
    battlefieldId    = xi.battlefield.id.TRIAL_SIZE_TRIAL_BY_LIGHTNING,
    canLoseExp       = false,
    maxPlayers       = 1,
    levelCap         = 20,
    timeLimit        = utils.minutes(15),
    index            = 2,
    entryNpc         = 'LP_Entrance',
    exitNpc          = 'Lightning_Protocrystal',
    requiredItems    = { xi.item.MINI_TUNING_FORK_OF_LIGHTNING },

    questArea = xi.questLog.OTHER_AREAS,
    quest     = xi.quest.id.otherAreas.TRIAL_SIZE_TRIAL_BY_LIGHTNING,
})

function content:entryRequirement(player, npc, isRegistrant, trade)
    return player:getMainJob() == xi.job.SMN and
        player:getMainLvl() >= 20
end

function content:onEventFinishWin(player, csid, option, npc)
    if not player:hasSpell(xi.magic.spell.RAMUH) then
        player:addSpell(xi.magic.spell.RAMUH)
        player:messageSpecial(cloisterOfStormsID.text.RAMUH_UNLOCKED, 0, 0, 5)
    end

    if not player:hasItem(xi.item.SCROLL_OF_INSTANT_WARP) then
        npcUtil.giveItem(player, xi.item.SCROLL_OF_INSTANT_WARP)
    end

    player:addFame(xi.fameArea.WINDURST, 30)
    player:completeQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.TRIAL_SIZE_TRIAL_BY_LIGHTNING)
end

content.groups =
{
    {
        mobIds =
        {
            { cloisterOfStormsID.mob.RAMUH_PRIME + 9  },
            { cloisterOfStormsID.mob.RAMUH_PRIME + 10 },
            { cloisterOfStormsID.mob.RAMUH_PRIME + 11 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
