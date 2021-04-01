-----------------------------------
-- Area: Windurst Woods
--  NPC: Lih Pituu
-- Type: Bonecraft Adv. Image Support
-- !pos -5.471 -6.25 -141.211 241
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/crafting")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local guildMember = isGuildMember(player, 2)
    local SkillLevel = player:getSkillLevel(xi.skill.BONECRAFT)
    local Cost = getAdvImageSupportCost(player, xi.skill.BONECRAFT)

    if guildMember == 1 then
        if not player:hasStatusEffect(xi.effect.BONECRAFT_IMAGERY) then
            player:startEvent(10018, Cost, SkillLevel, 0, 511, player:getGil(), 0, 7028, 0)
        else
            player:startEvent(10018, Cost, SkillLevel, 0, 511, player:getGil(), 28753, 3967, 0)
        end
    else
        player:startEvent(10018) -- Standard Dialogue
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    local Cost = getAdvImageSupportCost(player, 4)

    if csid == 10018 and option == 1 then
        player:delGil(Cost)
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 6, 0)
        player:addStatusEffect(xi.effect.BONECRAFT_IMAGERY, 3, 0, 480)
    end
end

return entity
