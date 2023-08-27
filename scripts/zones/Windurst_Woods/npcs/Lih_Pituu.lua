-----------------------------------
-- Area: Windurst Woods
--  NPC: Lih Pituu
-- Type: Bonecraft Adv. Image Support
-- !pos -5.471 -6.25 -141.211 241
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/crafting")
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -5.057, y = -5.250, z = -136.979, wait = 6000 },
    { x = -9.271, y = -5.250, z = -139.831, wait = 10000 },
    { x = -4.695, y = -5.250, z = -141.494, wait = 10000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local skillLevel = player:getSkillLevel(xi.skill.BONECRAFT)
    local cost = xi.crafting.getAdvImageSupportCost(player, xi.skill.BONECRAFT)

    if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.BONECRAFT) then
        if not player:hasStatusEffect(xi.effect.BONECRAFT_IMAGERY) then
            player:startEvent(10018, cost, skillLevel, 0, 511, player:getGil(), 0, 7028, 0)
        else
            player:startEvent(10018, cost, skillLevel, 0, 511, player:getGil(), 28753, 3967, 0)
        end
    else
        player:startEvent(10018) -- Standard Dialogue
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    local cost = xi.crafting.getAdvImageSupportCost(player, xi.skill.BONECRAFT)

    if csid == 10018 and option == 1 then
        player:delGil(cost)
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 6, 0)
        player:addStatusEffect(xi.effect.BONECRAFT_IMAGERY, 3, 0, 480)
    end
end

return entity
