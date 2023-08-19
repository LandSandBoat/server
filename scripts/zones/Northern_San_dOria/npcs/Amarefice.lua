-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Amarefice
-- Type: Woodworking Synthesis Image Support
-- !pos -181.506 10.15 259.905 231
-----------------------------------
local ID = zones[xi.zone.NORTHERN_SAN_DORIA]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local skillCap = xi.crafting.getCraftSkillCap(player, xi.skill.WOODWORKING)
    local skillLevel = player:getSkillLevel(xi.skill.WOODWORKING)

    if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.WOODWORKING) then
        if not player:hasStatusEffect(xi.effect.WOODWORKING_IMAGERY) then
            player:startEvent(624, skillCap, skillLevel, 1, 207, player:getGil(), 0, 4095, 0)
        else
            player:startEvent(624, skillCap, skillLevel, 1, 207, player:getGil(), 7127, 4095, 0)
        end
    else
        player:startEvent(624, skillCap, skillLevel, 1, 201, player:getGil(), 0, 0, 0) -- Standard Dialogue
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 624 and option == 1 then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 1, 1)
        player:addStatusEffect(xi.effect.WOODWORKING_IMAGERY, 1, 0, 120)
    end
end

return entity
