-----------------------------------
-- Area: Al Zahbi
--  NPC: Nudahaal
-- Type: Bonecraft Normal/Adv. Image Support
-- !pos -57.056 -7 -88.377 48
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/crafting")
local ID = require("scripts/zones/Al_Zahbi/IDs")
-----------------------------------

function onTrade(player, npc, trade)
    local guildMember = isGuildMember(player, 2)

    if guildMember == 1 then
        if trade:hasItemQty(2184, 1) and trade:getItemCount() == 1 then
            if player:hasStatusEffect(tpz.effect.BONECRAFT_IMAGERY) == false then
                player:tradeComplete()
                player:startEvent(225, 8, 0, 0, 0, 188, 0, 6, 0)
            else
                npc:showText(npc, ID.text.IMAGE_SUPPORT_ACTIVE)
            end
        end
    end
end

function onTrigger(player, npc)
    local guildMember = isGuildMember(player, 2)
    local SkillLevel = player:getSkillLevel(tpz.skill.BONECRAFT)

    if guildMember == 1 then
        if player:hasStatusEffect(tpz.effect.BONECRAFT_IMAGERY) == false then
            player:startEvent(224, 8, SkillLevel, 0, 511, 188, 0, 6, 2184)
        else
            player:startEvent(224, 8, SkillLevel, 0, 511, 188, 7121, 6, 2184)
        end
    else
        player:startEvent(224, 0, 0, 0, 0, 0, 0, 6, 0) -- Standard Dialogue
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 224 and option == 1 then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 6, 1)
        player:addStatusEffect(tpz.effect.BONECRAFT_IMAGERY, 1, 0, 120)
    elseif csid == 225 then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 6, 0)
        player:addStatusEffect(tpz.effect.BONECRAFT_IMAGERY, 3, 0, 480)
    end
end
