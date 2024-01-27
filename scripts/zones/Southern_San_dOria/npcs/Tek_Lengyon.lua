-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Tek Lengyon
-- Type: Leathercraft Synthesis Image Support
-- !pos -190.120 -2.999 2.770 230
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local skillCap = xi.crafting.getCraftSkillCap(player, xi.skill.LEATHERCRAFT)
    local skillLevel = player:getSkillLevel(xi.skill.LEATHERCRAFT)

    if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.LEATHERCRAFT) then
        if not player:hasStatusEffect(xi.effect.LEATHERCRAFT_IMAGERY) then
            player:startEvent(652, skillCap, skillLevel, 2, 239, player:getGil(), 0, 0, 0)
        else
            player:startEvent(652, skillCap, skillLevel, 2, 239, player:getGil(), 7075, 0, 0)
        end
    else
        player:startEvent(652) -- Standard Dialogue
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 652 and option == 1 then
        player:messageSpecial(ID.text.LEATHER_SUPPORT, 0, 5, 2)
        player:addStatusEffect(xi.effect.LEATHERCRAFT_IMAGERY, 1, 0, 120)
    end
end

return entity
