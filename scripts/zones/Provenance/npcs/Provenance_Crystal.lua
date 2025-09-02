-----------------------------------
--  Area: Provenance
--  NPC: Provenance_Crystal
-----------------------------------
local ID = require("scripts/zones/Provenance/IDs")
require('scripts/globals/npc_util')
-----------------------------------
---@type TNpcEntity
local entity = {}

local mentorShop = {
    { xi.item.FURIA_LEGGINGS, 1 },
    { xi.item.EBUR_LEGGINGS, 1 },
    { xi.item.FURIA_HOSE, 1 },
    { xi.item.EBUR_HOSE, 1 },
    { xi.item.FURIA_GAUNTLETS, 1 },
    { xi.item.EBUR_GAUNTLETS, 1 },
    { xi.item.FURIA_BREASTPLATE, 1 },
    { xi.item.EBUR_BREASTPLATE, 1 },
    { xi.item.FURIA_ARMET, 1 },
    { xi.item.EBUR_ARMET, 1 },
    { xi.item.FLASK_OF_POISON_POTION, 200}
}

entity.onTrigger = function(player,npc)
    local mentorFlag = player:getCharVar("MentorFlag")
    local mentorIntro = player:getLocalVar("MentorIntro")
    local playtime = player:getPlaytime(false)
    local mainLevel = player:getMainLvl()

    -- Non-mentor player, eligible for mentor status
    if mentorFlag == 0 and playtime < 1800 and mainLevel == 1 then
        if mentorIntro == 0 then
            -- First interaction
            player:printToPlayer("Touching this crystal again will set this character to Mentor status.", xi.msg.channel.SAY, "Era Staff")
            player:printToPlayer("Mentor is a life-long commitment of a 1x EXP rate that is not reversible.", xi.msg.channel.SAY, "Era Staff")
            player:printToPlayer("It's recommended you read up on it at https://ffera.fandom.com/wiki/Mentor", xi.msg.channel.SAY, "Era Staff")
            player:setLocalVar("MentorIntro", 1)
        elseif mentorIntro == 1 then
            -- Warning
            player:printToPlayer("We're very serious about this being a permanent change! We will not change it afterwards!", xi.msg.channel.SAY, "Era Staff")
            player:printToPlayer("Touch this crystal again only if you are very certain you want to become a Mentor!", xi.msg.channel.SAY, "Era Staff")
            player:setLocalVar("MentorIntro", 2)
        elseif mentorIntro == 2 then
            -- Confirm mentor status
            player:printToPlayer("This contract... is SEALED!", xi.msg.channel.SAY, "Era Staff")
            player:printToPlayer("You are now a Mentor forever. As a token of our sympathy, here's a Chocobo Whistle!", xi.msg.channel.SAY, "Era Staff")

            -- Set mentor status
            player:setMentor(true)
            player:setCharVar("MentorFlag", 1)
            -- player:setSpeed(150) need to find a better way to set speed for mentors
            npcUtil.giveItem(player, xi.item.CHOCOBO_WHISTLE)
            player:setLocalVar("MentorIntro", 0)
        end

    -- Already a mentor
    elseif mentorFlag == 1 then
        if mainLevel >= 75 then
            -- Check for mentor achievement key item
            if not player:hasKeyItem(xi.ki.GOOBBUE_COMPANION) then
                player:printToPlayer("In recognition of attaining level 75 on a job as a Mentor, enjoy this exclusive gift!", xi.msg.channel.SAY, "Era Staff")
                npcUtil.giveKeyItem(player, xi.ki.GOOBBUE_COMPANION)
            else
                -- Show mentor shop
                xi.shop.general(player, mentorShop)
            end
        elseif mainLevel >= 71 then
            -- Show mentor shop for 71+
            xi.shop.general(player, mentorShop)
        else
            player:printToPlayer("Continue your journey as a Mentor. Special rewards await at level 71+!", xi.msg.channel.SAY, "Era Staff")
        end
    end
end

entity.onTrade = function(player, npc, trade)
end

return entity
