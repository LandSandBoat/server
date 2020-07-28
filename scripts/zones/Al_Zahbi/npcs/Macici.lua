-----------------------------------
-- Area: Al Zahbi
--  NPC: Macici
-- Type: Smithing Normal/Adv. Image Support
-- !pos -35.163 -1 -31.351 48
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/crafting")
local ID = require("scripts/zones/Al_Zahbi/IDs")
-----------------------------------

function onTrade(player, npc, trade)
    local guildMember = isGuildMember(player, 8)

    if guildMember == 1 then
        if trade:hasItemQty(2184, 1) and trade:getItemCount() == 1 then
            if player:hasStatusEffect(tpz.effect.SMITHING_IMAGERY) == false then
                player:tradeComplete()
                player:startEvent(233, 8, 0, 0, 0, 188, 0, 2, 0)
            else
                npc:showText(npc, ID.text.IMAGE_SUPPORT_ACTIVE)
            end
        end
    end
end

function onTrigger(player, npc)
    local guildMember = isGuildMember(player, 8)
    local SkillLevel = player:getSkillLevel(tpz.skill.SMITHING)

    if guildMember == 1 then
        if player:hasStatusEffect(tpz.effect.SMITHING_IMAGERY) == false then
            player:startEvent(232, 8, SkillLevel, 0, 511, 188, 0, 2, 2184)
        else
            player:startEvent(232, 8, SkillLevel, 0, 511, 188, 6566, 2, 2184)
        end
    else
        player:startEvent(232, 0, 0, 0, 0, 0, 0, 2, 0) -- Standard Dialogue
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if csid == 232 and option == 1 then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 2, 1)
        player:addStatusEffect(tpz.effect.SMITHING_IMAGERY, 1, 0, 120)
    elseif csid == 233 then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 2, 0)
        player:addStatusEffect(tpz.effect.SMITHING_IMAGERY, 3, 0, 480)
    end
end
