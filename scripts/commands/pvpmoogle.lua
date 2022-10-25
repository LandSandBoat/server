-----------------------------------
-- CatsEyeXI PVP Moogle
-- For staff hosted PVP events
-----------------------------------

cmdprops =
{
    permission = 3,
    parameters = ""
}

function onTrigger(player)
    local zone = player:getZone()
    local npc= zone:insertDynamicEntity({
        objtype = xi.objType.NPC,
        name = "PVP Moogle",
        look = 2406,
        x = player:getXPos(),
        y = player:getYPos(),
        z = player:getZPos(),
        rotation = player:getRotPos(),

        onTrade = function(player, npc, trade)
            player:PrintToPlayer("That's not needed.", 0, npc:getPacketName())
        end,

    onTrigger = function(player, npc)
    -- Forward declarations (required)
    local menu  = {}
    local page1 = {}
    local page2 = {}

    local delaySendMenu = function(player)
        player:timer(100, function(playerArg)
            playerArg:customMenu(menu)
        end)
    end
    player:PrintToPlayer("Hello! I'm the offical CatsEyeXI PVP Moogle, here to assist with all your PVP needs.", 0, npc:getPacketName())
    menu =
    {
        title = "Pick an option.",
        options = {},
    }

    page1 =
    {
        {
            "Turn your PVP flag on. (Bastok)",
            function(playerArg)
                player:timer(50, function(playerArg)
                    playerArg:PrintToPlayer("PVP status on!", 0, npc:getPacketName())
                    player:addStatusEffectEx(xi.effect.ENCUMBRANCE_I, xi.effect.ENCUMBRANCE_I, 0xFFFF, 0, 6000)
                    player:addStatusEffect(xi.effect.RERAISE, 3, 0, 7200)
                    player:addStatusEffect(xi.effect.COSTUME, 957, 0, 300)
                    player:setAllegiance(3)
                end)
            end,
        },
        {
            "Turn your PVP flag on. (San d'Oria)",
            function(playerArg)
                player:timer(50, function(playerArg)
                    playerArg:PrintToPlayer("PVP status on!", 0, npc:getPacketName())
                    player:addStatusEffectEx(xi.effect.ENCUMBRANCE_I, xi.effect.ENCUMBRANCE_I, 0xFFFF, 0, 6000)
                    player:addStatusEffect(xi.effect.RERAISE, 3, 0, 7200)
                    player:addStatusEffect(xi.effect.COSTUME, 158, 0, 300)
                    player:setAllegiance(2)
                end)
            end,
        },
        {
            "Turn your PVP flag on. (Windurst)",
            function(playerArg)
                player:timer(50, function(playerArg)
                    playerArg:PrintToPlayer("PVP status on!", 0, npc:getPacketName())
                    player:addStatusEffectEx(xi.effect.ENCUMBRANCE_I, xi.effect.ENCUMBRANCE_I, 0xFFFF, 0, 6000)
                    player:addStatusEffect(xi.effect.RERAISE, 3, 0, 7200)
                    player:addStatusEffect(xi.effect.COSTUME, 182, 0, 300)
                    player:setAllegiance(4)
                end)
            end,
        },
        {
            "Next Page",
            function(playerArg)
                menu.options = page2
                delaySendMenu(playerArg)
            end,
        },
    }

    page2 =
    {
        {
            "Turn your PVP flag off.",
            function(playerArg)
                player:timer(50, function(playerArg)
                    playerArg:PrintToPlayer("PVP status off!", 0, npc:getPacketName())
                    player:delStatusEffect(xi.effect.ENCUMBRANCE_I)
                    player:delStatusEffect(xi.effect.RERAISE)
                    player:delStatusEffect(xi.effect.MAX_HP_BOOST)
                    player:delStatusEffect(xi.effect.MAX_MP_BOOST)
                    player:delStatusEffect(xi.effect.REGEN)
                    player:addStatusEffect(xi.effect.COSTUME, 1997, 0, 300)
                    player:setAllegiance(0)
                    player:delItem(5241, 1) --giant's drink
                    player:delItem(5242, 1) --wizard's drink
                    player:delItem(4254, 1) --megalixar
                    player:delItem(4206, 1) --Catholicon
                    player:delItem(5437, 1) --Strange milk
                end)
            end,
        },
        {
            "Remove weakness and restore HP.",
            function(playerArg)
                player:timer(50, function(playerArg)
                end)
                if player:getAllegiance() > 1 and
                    player:hasStatusEffect(xi.effect.WEAKNESS)then
                    player:timer(1000, function(player)
                    player:delStatusEffect(xi.effect.WEAKNESS)
                    end)
                    player:timer(3000, function(player)
                    player:addHP(player:getMaxHP())
                    end)
                    player:timer(4000, function(player)
                    player:addMP(player:getMaxMP())
                    end)
                    player:addStatusEffect(xi.effect.RERAISE, 3, 0, 7200)
                    playerArg:PrintToPlayer("Your weakness has been cured and your health restored!", 0, npc:getPacketName())
                else
                    playerArg:PrintToPlayer("You must have your PVP flag ON and have weakness to use this.", 0, npc:getPacketName())
                end
            end,
        },
        {
        "Get Temporary items.",
        function(playerArg)
            player:timer(50, function(playerArg)
                if player:getAllegiance() > 1 then
                    if player:getFreeSlotsCount() >= 5 then
                        playerArg:PrintToPlayer("You receive several temporary items!", 0, npc:getPacketName())
                        player:addItem(5241, 1) --giant's drink
                        player:addItem(5242, 1) --wizard's drink
                        player:addItem(4254, 1) --megalixar
                        player:addItem(4206, 1) --Catholicon
                        player:addItem(5437, 1) --Strange milk
                    else
                        playerArg:PrintToPlayer("You need more room in your bag to obtain these items.", 0, npc:getPacketName())
                    end
                    elseif player:getAllegiance() < 2 then
                        playerArg:PrintToPlayer("You must have your PVP flag ON to recieve temporary items.", 0, npc:getPacketName())
                end
            end)
        end,
        },
        {
            "Exit",
            function(playerArg)
                return
            end,
        },
    }

    menu.options = page1
    delaySendMenu(player)

        end,
    })
player:PrintToPlayer(string.format("WARNING, this Dynamic NPC is not to be left unattended, it's for staff hosted events only!", npc:getPacketName()))
player:PrintToPlayer(string.format("When no longer needed use !getid and then !exec GetNPCByID(ID#goesHere):setStatus(xi.status.DISAPPEAR)", npc:getPacketName()))
end
