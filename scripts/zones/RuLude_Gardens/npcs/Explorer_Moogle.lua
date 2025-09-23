-----------------------------------
-- Area: Ru'Lude Gardens
-- NPC: Explorer Moogle
-- Era: Custom NM Hunt
-- !pos -61 6 -6 243
-----------------------------------
local ID = zones[xi.zone.RULUDE_GARDENS]
require('scripts/globals/npc_util')
require('modules/custom/lua/nmhunt')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local COMPLETEBY = player:getVar(xi.nmHunt.vars.COMPLETE_BY)
    local NEXTNM = player:getVar(xi.nmHunt.vars.NEXT_HUNT)
    local huntScore = player:getVar(xi.nmHunt.vars.HUNT_SCORE)
    local huntCleared = player:getVar(xi.nmHunt.vars.HUNT_CLEARED)
    local PATTERN = player:getVar(xi.nmHunt.vars.HUNT_PATTERN)
    local currentTime = os.time()
    
    -- Check if eligible for new hunt
    if NEXTNM <= currentTime and COMPLETEBY == 0 then
        -- Pick a random hunt target
        local huntIndex, huntData = xi.nmHunt.getRandomTarget()
        local targetMobId = xi.nmHunt.getMobId(huntData)
        
        -- Set the hunt variables
        player:setVar(xi.nmHunt.vars.HUNT_TARGET, targetMobId)
        player:setVar(xi.nmHunt.vars.HUNT_PATTERN, huntIndex)
        player:setVar(xi.nmHunt.vars.NEXT_HUNT, 0)
        player:setVar(xi.nmHunt.vars.COMPLETE_BY, currentTime + xi.nmHunt.config.huntDuration)
        
        if huntScore == 0 then
            player:printToPlayer("Welcome to Era's NM Hunt. I'll give you 2 weeks to find this being. Your clue is:", xi.msg.channel.SAY, "NM Hunt")
        else
            player:printToPlayer(string.format("Welcome back. So far, you've completed %d hunts for me. Your new clue is:", huntScore), xi.msg.channel.SAY, "NM Hunt")
        end
        
        player:printToPlayer(huntData.clue, xi.msg.channel.SAY, "NM Hunt")
        player:printToPlayer("Once you believe you killed the right NM come straight back and talk to me to see. Don't kill another NM until checking!", xi.msg.channel.SAY, "NM Hunt")
        
    -- Check if hunt expired
    elseif COMPLETEBY <= currentTime and COMPLETEBY ~= 0 then
        player:printToPlayer("Your current hunt seems to have expired, check again to sign up for another.", xi.msg.channel.SAY, "NM Hunt")
        xi.nmHunt.clearHunt(player)
        
    -- Check if player has an active hunt
    elseif PATTERN ~= 0 then
        -- Hunt completed successfully
        if huntCleared == 1 and COMPLETEBY ~= 0 then
            if player:getFreeSlotsCount() > 1 then
                local rewardRoll = math.random(1, 100)
                
                if rewardRoll >= (100 - xi.nmHunt.config.itemRewardChance) then
                    -- Item reward
                    npcUtil.giveItem(player, xi.nmHunt.standardRewards[math.random(1, #xi.nmHunt.standardRewards)])
                else
                    -- Gil reward
                    local gilAmount = math.random(xi.nmHunt.config.gilMin, xi.nmHunt.config.gilMax)
                    player:addGil(gilAmount)
                    player:messageSpecial(ID.text.GIL_OBTAINED, gilAmount)
                end
                
                -- Update hunt stats
                xi.nmHunt.clearHunt(player)
                player:setVar(xi.nmHunt.vars.NEXT_HUNT, currentTime + xi.nmHunt.config.cooldownTime)
                player:setVar(xi.nmHunt.vars.HUNT_SCORE, huntScore + 1)
                
                player:printToPlayer(string.format("Congrats, you solved the riddle and killed it! You have now completed %d hunts.", huntScore + 1), xi.msg.channel.SAY, "NM Hunt")
                
                -- Check for milestone reward
                local newScore = huntScore + 1
                if newScore % 5 == 0 and xi.nmHunt.milestoneRewards[newScore] then
                    npcUtil.giveItem(player, xi.nmHunt.milestoneRewards[newScore])
                end
            else
                player:printToPlayer("Why don't you free up 2 inventory slots and talk to me again.", xi.msg.channel.SAY, "NM Hunt")
            end
            
        -- Hunt still active, give reminder
        elseif COMPLETEBY >= currentTime and COMPLETEBY ~= 0 then
            player:printToPlayer("They are still out there, keep looking!", xi.msg.channel.SAY, "NM Hunt")
            player:printToPlayer(string.format("You still have %d hours to find the one I seek.", math.floor((COMPLETEBY - currentTime) / 3600)), xi.msg.channel.SAY, "NM Hunt")
            player:printToPlayer("Here's the clue again to help you out:", xi.msg.channel.SAY, "NM Hunt")
            player:printToPlayer(xi.nmHunt.targets[PATTERN].clue, xi.msg.channel.SAY, "NM Hunt")
        end
        
    -- On cooldown
    else
        local timeRemaining = NEXTNM - currentTime
        if timeRemaining / 60 <= 90 then
            player:printToPlayer(string.format("Sorry, you must wait %d more minutes for your next hunt. You have racked up %d kills so far.", 
                math.floor(timeRemaining / 60), huntScore), xi.msg.channel.SAY, "NM Hunt")
        else
            player:printToPlayer(string.format("Sorry, you must wait %d more hours for your next hunt. You have racked up %d kills so far.", 
                math.floor(timeRemaining / 3600), huntScore), xi.msg.channel.SAY, "NM Hunt")
        end
    end
end

return entity
