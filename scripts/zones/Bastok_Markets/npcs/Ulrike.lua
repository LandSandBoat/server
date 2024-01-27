-----------------------------------
-- Area: Bastok Markets
--  NPC: Ulrike
-- Type: Goldsmithing Synthesis Image Support
-- !pos -218.399 -7.824 -56.203 235
-----------------------------------
local ID = zones[xi.zone.BASTOK_MARKETS]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local skillCap = xi.crafting.getCraftSkillCap(player, xi.skill.GOLDSMITHING)
    local skillLevel = player:getSkillLevel(xi.skill.GOLDSMITHING)

    if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.GOLDSMITHING) then
        if not player:hasStatusEffect(xi.effect.GOLDSMITHING_IMAGERY) then
            player:startEvent(304, skillCap, skillLevel, 2, 201, player:getGil(), 0, 9, 0)
        else
            player:startEvent(304, skillCap, skillLevel, 2, 201, player:getGil(), 6975, 9, 0)
        end
    else
        player:startEvent(304)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 304 and option == 1 then
        player:delStatusEffectsByFlag(xi.effectFlag.SYNTH_SUPPORT, true)
        player:addStatusEffect(xi.effect.GOLDSMITHING_IMAGERY, 1, 0, 120)
        player:messageSpecial(ID.text.GOLDSMITHING_SUPPORT, 0, 3, 2)
    end
end

return entity
