-----------------------------------
-- Area: Al Zahbi
--  NPC: Rajaaha
-- Type: Goldsmithing Normal/Adv. Image Support
-- !pos 49.9 0.1 -45.2 48
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/crafting")
local ID = require("scripts/zones/Al_Zahbi/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local guildMember = xi.crafting.isGuildMember(player, 6)

    if guildMember == 1 then
        if trade:hasItemQty(2184, 1) and trade:getItemCount() == 1 then
            if player:hasStatusEffect(xi.effect.GOLDSMITHING_IMAGERY) == false then
                player:tradeComplete()
                player:startEvent(231, 8, 0, 0, 0, 188, 0, 3, 0)
            else
                npc:showText(npc, ID.text.IMAGE_SUPPORT_ACTIVE)
            end
        end
    end

end

entity.onTrigger = function(player, npc)
    local guildMember = xi.crafting.isGuildMember(player, 6)
    local SkillLevel = player:getSkillLevel(xi.skill.GOLDSMITHING)

    if guildMember == 1 then
        if player:hasStatusEffect(xi.effect.GOLDSMITHING_IMAGERY) == false then
            player:startEvent(230, 8, SkillLevel, 0, 511, 188, 0, 3, 2184)
        else
            player:startEvent(230, 8, SkillLevel, 0, 511, 188, 7101, 3, 2184)
        end
    else
        player:startEvent(230, 0, 0, 0, 0, 0, 0, 3, 0) -- Standard Dialogue
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 230 and option == 1 then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 3, 1)
        player:addStatusEffect(xi.effect.GOLDSMITHING_IMAGERY, 1, 0, 120)
    elseif csid == 231 then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 3, 0)
        player:addStatusEffect(xi.effect.GOLDSMITHING_IMAGERY, 3, 0, 480)
    end
end

return entity
