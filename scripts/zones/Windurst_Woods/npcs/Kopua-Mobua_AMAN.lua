-----------------------------------
-- Area: Windurst Woods
--  NPC: Kopua-Mobua A.M.A.N.
-- Type: Mentor Recruiter
-- !pos -23.134 1.749 -67.284 241
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local rot = npc:getRotPos()

    if not player:getMentor() then
        player:faceTarget(npc)
        if player:getMainLvl() >= 30 and player:getPlaytime() >= 648000 then
            player:PrintToPlayer("Greetings adventurer! I'm with the Adventurers' Mutual Aid Network (AMAN) and am now taking applications for new mentors.", xi.msg.channel.SAY, npc:getPacketName())
            player:timer(1000, function(playerArg)
                playerArg:PrintToPlayer("Congratulations! You are qualified to be a mentor!", xi.msg.channel.SAY, npc:getPacketName())
            end)

            player:timer(2500, function(playerArg)
                playerArg:PrintToPlayer("Please note that registering and serving as a mentor, as well as utilizing the services of the Mentor Program, are done at the player's own discretion.", xi.msg.channel.SAY, npc:getPacketName())
            end)

            player:timer(4000, function(playerArg)
                playerArg:PrintToPlayer(string.format("%s is not responsible for actions or comments of any mentors. No benefits are provided to those who choose to participate in the Mentor Program.", xi.settings.main.SERVER_NAME), xi.msg.channel.SAY, npc:getPacketName())
            end)

            player:timer(5500, function(playerArg)
                playerArg:PrintToPlayer("You are now a registered mentor.", xi.msg.channel.SAY, npc:getPacketName())
            end)

            player:timer(7000, function(playerArg)
                playerArg:PrintToPlayer("You can enable \"Mentor Status\" by using the command /mentor on. You can disable the status by using /mentor off.", xi.msg.channel.SAY, npc:getPacketName())
            end)

            player:timer(8500, function(playerArg)
                playerArg:PrintToPlayer("Mentor status can also be switched on and off in the \"Config\" menu found within the \"Help Desk.\"", xi.msg.channel.SAY, npc:getPacketName()) npc:setRotation(rot)
            end)

            player:setMentor(true)
        else
            player:PrintToPlayer("Greetings adventurer! I'm with the Adventurers' Mutual Aid Network (AMAN) and am now taking applications for new mentors.", xi.msg.channel.SAY, npc:getPacketName())
            player:timer(1000, function(playerArg)
                playerArg:PrintToPlayer("What is a mentor, you ask? Well, a mentor is an experienced adventurer who is willing to offer their time to help out their less traveled companions.", xi.msg.channel.SAY, npc:getPacketName())
            end)

            player:timer(2500, function(playerArg)
                playerArg:PrintToPlayer("To become a mentor, you must have attained level 30 and have accumplated more than 180 hours of play time.", xi.msg.channel.SAY, npc:getPacketName())
            end)

            player:timer(4000, function(playerArg)
                playerArg:PrintToPlayer("Please note that registering and serving as a mentor, as well as utilizing the services of the Mentor Program, are done at the player's own discretion.", xi.msg.channel.SAY, npc:getPacketName())
            end)

            player:timer(5500, function(playerArg)
                playerArg:PrintToPlayer(string.format("%s is not responsible for actions or comments of any mentors. No benefits are provided to those who choose to participate in the Mentor Program.", xi.settings.main.SERVER_NAME), xi.msg.channel.SAY, npc:getPacketName())
            end)

            player:timer(7000, function(playerArg)
                playerArg:PrintToPlayer("Once you have met the requirements to become a mentor, please speak with me again.", xi.msg.channel.SAY, npc:getPacketName()) playerArg:delStatusEffectSilent(xi.effect.STUN)
            end)
        end
    elseif player:getMentor() then
        player:startEvent(10026, 10)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
