-----------------------------------
-- World First Announcements
--
-- Send worldwide messages when certain conditions are met for the first time.
--
-- NOTE: GetVolatileServerVariable/SetVolatileServerVariable are cached, so are cheap to use every time (*apart from the first).
--     : It is recommended you go and look at the implementation to see how these work.
--
-- You can look up who did what with this SQL query:
-- SELECT
--     server_variables.`name`, chars.charname
-- FROM
--     server_variables
-- INNER JOIN
--     chars ON server_variables.value = chars.charid
-- WHERE
--     server_variables.`name` LIKE "WF_%" OR
--     server_variables.`name` LIKE "WT_%"
-----------------------------------
require('modules/module_utils')
require('scripts/globals/mobs')
require('scripts/globals/player')
-----------------------------------
local m = Module:new('world_first_announcements')

local openingDecoration = '\129\154'
local closingDecoration = '\129\154'

local checkWorldFirstServerVar = function(player, varName, worldMessage)
    local worldFirst = string.format('WF_%s', varName)
    local worldTime  = string.format('WT_%s', varName)

    if GetVolatileServerVariable(worldFirst) == 0 then -- Record hasn't been set yet
        local decoratedMessage = string.format('%s %s %s', openingDecoration, worldMessage, closingDecoration)
        player:PrintToArea(decoratedMessage, xi.msg.channel.SYSTEM_3, 0, '') -- Sends announcement via ZMQ to all processes and zones

        -- Write out World First (WF) and World First Time (WT) to server vars)
        SetVolatileServerVariable(worldFirst, player:getID())
        SetVolatileServerVariable(worldTime, os.time())

        -- Summon big swirly starry animation which lingers on the players client in the location
        -- where this event happened. It will linger in that area for anyone that saw it until
        -- they zone.
        -- player:independentAnimation(player, 12, 3)
    end
end

m:addOverride('xi.player.onPlayerDeath', function(player)
    super(player)

    checkWorldFirstServerVar(player,
        'PLAYER_DEATH',
        string.format('%s has been the first player to die!', player:getName()))
end)

m:addOverride('xi.player.onPlayerLevelUp', function(player)
    super(player)

    checkWorldFirstServerVar(player,
        'PLAYER_LEVEL_UP',
        string.format('%s has been the first player to level up!', player:getName()))

    local levelMilestones = { 10, 20, 30, 40, 50, 60, 70, 75, 80, 90, 99 }
    for _, level in pairs(levelMilestones) do
        if player:getMainLvl() == level then
            checkWorldFirstServerVar(player,
                string.format('JOB_%u_%s', level, xi.jobNames[player:getMainJob()][1]),
                string.format('%s has been the first player to reach level %u on %s!', player:getName(), level, xi.jobNames[player:getMainJob()][2]))
        end
    end
end)

m:addOverride('xi.player.onPlayerLevelDown', function(player)
    super(player)

    checkWorldFirstServerVar(player,
        'PLAYER_LEVEL_DOWN',
        string.format('%s has been the first player to level down!', player:getName()))
end)

m:addOverride('xi.mob.onMobDeathEx', function(mob, player, isKiller, isWeaponSkillKill)
    super(mob, player, isKiller, isWeaponSkillKill)

    if mob:isNM() and isKiller then
        local nmName, _ = string.gsub(mob:getName(), '_', ' ')
        checkWorldFirstServerVar(player,
            'NM_KILL_' .. string.upper(mob:getName()),
            string.format('%s has been killed for the first time by %s!', nmName, player:getName()))
    end
end)

--[[
    NOTE: For this to work, the quest 'ELDER_MEMORIES' will need to be adjusted to use npcUtil.completeQuest,
        : or be rewritten to use the interaction framework.

m:addOverride('npcUtil.completeQuest', function(player, area, quest, params)
    local result = super(player, area, quest, params)

    if result and area == xi.quest.log_id.OTHER_AREAS and quest == xi.quest.id.otherAreas.ELDER_MEMORIES then
        checkWorldFirstServerVar(player,
            'UNLOCK_SJ',
            string.format('%s has been the first player to unlock their subjob!', player:getName()))
    end

    return result
end)
]]

return m
