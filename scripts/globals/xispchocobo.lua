xi = xi or {}
xi.xispchocobo = xi.xispchocobo or {}

local menu1 = {}
local dialogue1 = {}


menu1 =
{
    title = 'Would you like to raise a new chocobo?',
    options = {},
}

dialogue1 =
{
    {
        'Can\'t wait!',
        function(playerArg)
            if playerArg:getCharVar('[XISP]hasChocobo') == 1 then
                playerArg:printToPlayer("It appears you already have a chocobo.", xi.msg.channel.SAY, ' ')
            else
                playerArg:printToPlayer("Congratulations on your new chocobo! All the best to you both.", xi.msg.channel.SAY, ' ')
                playerArg:setCharVar('[XISP]hasChocobo', 1)
                playerArg:setCharVar('[XISP]chocoGrow', 0)
                playerArg:setCharVar('[XISP]hasEgg', 0)

                local colorChance = math.random(1, 100)
                if colorChance <= 3 then
                    playerArg:setCharVar('[XISP]chocoColor', 2) -- Black   3% chance
                elseif colorChance <= 8 then
                    playerArg:setCharVar('[XISP]chocoColor', 4) -- Blue    5% chance
                elseif colorChance <= 13 then
                    playerArg:setCharVar('[XISP]chocoColor', 6) -- Red     5% chance
                elseif colorChance <= 18 then
                    playerArg:setCharVar('[XISP]chocoColor', 8) -- Green   5% chance
                else
                    playerArg:setCharVar('[XISP]chocoColor', 1) -- Normal 82% chance
                end

                xi.xispchocobo.spawnChocobo(playerArg, playerArg:getZone())
            end
        end,
    },
    {
        'On second thought...',
        function(playerArg)
        end,
    },
}

xi.xispchocobo.onTrainerTrade = function(player, npc, trade)
    local name = npc:getName()

    if trade then
        if
            npcUtil.tradeHasExactly(trade, xi.item.CHOCOBO_EGG_FAINTLY_WARM) or
            npcUtil.tradeHasExactly(trade, xi.item.CHOCOBO_EGG_SLIGHTLY_WARM) or
            npcUtil.tradeHasExactly(trade, xi.item.CHOCOBO_EGG_A_BIT_WARM) or
            npcUtil.tradeHasExactly(trade, xi.item.CHOCOBO_EGG_A_LITTLE_WARM) or
            npcUtil.tradeHasExactly(trade, xi.item.CHOCOBO_EGG_SOMEWHAT_WARM)
        then
            if player:getCharVar('[XISP]hasChocobo') == 1 then
                player:printToPlayer("It looks like you already have a chocobo.", xi.msg.channel.SAY, name)
            else
                player:printToPlayer("A new chocobo egg? How wonderful! I will hold onto it for you.", xi.msg.channel.SAY, name)
                player:setCharVar('[XISP]hasEgg', 1)
                player:confirmTrade()

                menu1.options = dialogue1
                xi.xisp.sendMenu(player, menu1)
            end
        end
    end
end

xi.xispchocobo.onTrainerTrigger = function(player, npc)
    if player:getCharVar('[XISP]hasEgg') == 1 then
        menu1.options = dialogue1
        xi.xisp.sendMenu(player, menu1)
    end
end

xi.xispchocobo.chocoboTrigger = function(player, choco)
    menu =
    {
        title = 'Would you like to mount your chocobo?',
        options = {},
    }

    dialogue =
    {
        {
            'Yes',
            function(playerArg)
                local choco = GetMobByID(playerArg:getCharVar('[XISP]chocoID'))
                if choco then
                    playerArg:delStatusEffectSilent(xi.effect.MOUNTED)
                    playerArg:setLocalVar('ownChoco', 1)

                    local traits =
                    {
                        largeBeak   = false,
                        fullTail    = false,
                        largeTalons = false,
                    }

                    -- This line registers the player's chocobo as the player's mount
                    playerArg:registerChocobo(playerArg:getCharVar('[XISP]chocoColor'), traits)

                    playerArg:addStatusEffectEx(xi.effect.MOUNTED, xi.effect.MOUNTED, xi.mount.CHOCOBO, 0, 1800, 0, 360, true)
                    choco:setBehavior(bit.band(choco:getBehavior(), bit.bnot(xi.behavior.NO_DESPAWN)))
                    DespawnMob(choco:getID())
                end
            end,
        },
        {
            'Not right now.',
            function(playerArg)
            end,
        },
    }

    local chocogrow = player:getCharVar('[XISP]chocoGrow')

    if chocogrow >= 20 then -- Adult
        if choco:getLocalVar('[XISP]ownerID') ~= player:getID() then
            player:printToPlayer("This chocobo does not seem to recognize you as its owner.", xi.msg.channel.NS_SAY, ' ')
            return
        elseif player:getMainLvl() < 20 then
            player:printToPlayer("You need to be at least level 20 to ride your chocobo.", xi.msg.channel.NS_SAY, ' ')
            return
        elseif #player:getNotorietyList() > 0 then
            player:printToPlayer("You cannot mount your chocobo while in combat.", xi.msg.channel.NS_SAY, ' ')
            return
        elseif player:getCharVar('[XISP]chocoboTimer') > os.time() then -- Timer set when getting off mount
            player:printToPlayer("Your chocobo appears too tired to ride.", xi.msg.channel.NS_SAY, ' ')
            return
        end

        menu.options = dialogue
        xi.xisp.sendMenu(player, menu)

    else
        if player:getCharVar('[XISP]chocoWait') <= VanadielUniqueDay() then
            player:setCharVar('[XISP]chocoGrow', chocogrow + 1)
            player:setCharVar('[XISP]chocoWait', VanadielUniqueDay() + 1)
            chocogrow = player:getCharVar('[XISP]chocoGrow')

            if chocogrow < 1 then
                player:printToPlayer("Your chocobo seems a little nervous.", xi.msg.channel.SYSTEM_3, ' ')
            elseif chocogrow < 3 then
                player:printToPlayer("Your chocobo has begun to warm up to you.", xi.msg.channel.SYSTEM_3, ' ')
            elseif chocogrow < 6 then
                player:printToPlayer("Your chocobo refuses to leave your side.", xi.msg.channel.SYSTEM_3, ' ')
            elseif chocogrow <= 9 then
                player:printToPlayer("Your chocobo has come to adore you.", xi.msg.channel.SYSTEM_3, ' ')
            elseif chocogrow <= 12 then
                player:printToPlayer("Your chocobo is growing rapidly!", xi.msg.channel.SYSTEM_3, ' ')
            elseif chocogrow <= 15 then
                player:printToPlayer("Your chocobo considers you as their parent.", xi.msg.channel.SYSTEM_3, ' ')
            elseif chocogrow <= 19 then
                player:printToPlayer("Your chocobo seems almost fully grown!", xi.msg.channel.SYSTEM_3, ' ')
            else
                -- Chocobo all grown up!
                choco:entityAnimationPacket(xi.animationString.SPECIAL_20)
            end
        end

        if chocogrow < 1 then
            choco:entityAnimationPacket(xi.animationString.SPECIAL_00)
        elseif chocogrow < 3 then
            choco:entityAnimationPacket(xi.animationString.SPECIAL_30)
        elseif chocogrow < 6 then
            choco:entityAnimationPacket(xi.animationString.SPECIAL_30)
        elseif chocogrow <= 9 then
            choco:entityAnimationPacket(xi.animationString.SPECIAL_20)
            choco:independentAnimation(choco, 252, 4)
        else
            choco:independentAnimation(choco, 251, 4)
        end
    end
end

xi.xispchocobo.spawnChocobo = function(player, zone)
    if player:getCharVar('[XISP]hasChocobo') == 1 then
        local look       = "0x0700200000000000000000000000000000000000" -- Default yellow chocobo
        local pos        = player:getPos()
        local name       = "Chocobo"
        local chocoStage = player:getCharVar('[XISP]chocoGrow')
        local color      = player:getCharVar('[XISP]chocoColor')
        local babyLook   = 1997

        if chocoStage < 10 then
            name = "Baby Chocobo"
        elseif chocoStage < 20 then
            name = "Young Chocobo"
        end

        -- Alternatively check for zones we don't want chocobo in
        if
            player:getStatusEffect(xi.effect.MOUNTED) ~= nil or
            (chocoStage >= 20 and zone:getTypeMask() ~= xi.zoneType.OUTDOORS)
        then
            return
        end

        -- Check for color overrides (Teen)
        if chocoStage >= 10 and chocoStage < 20 then
            if color == 2 then -- Black
                babyLook = 1999
            elseif color == 4 then -- Blue
                babyLook = 2000
            elseif color == 6 then -- Red
                babyLook = 2001
            elseif color == 8 then -- Green
                babyLook = 2002
            else
                babyLook = 1998 -- Normal Teen
            end

        -- Check for color overrides (Adult)
        elseif chocoStage >= 20 then
            if color == 2 then
                look = "0x0700210000000000000000000000000000000000" -- Black
            elseif color == 4 then
                look = "0x0700220000000000000000000000000000000000" -- Blue
            elseif color == 6 then
                look = "0x0700230000000000000000000000000000000000" -- Red
            elseif color == 8 then
                look = "0x0700240000000000000000000000000000000000" -- Green
            end
        end

        local choco = zone:insertDynamicEntity({
            objtype               = xi.objType.MOB,
            -- allegiance            = xi.allegiance.PLAYER,
            name                  = name,
            x                     = pos.x,
            y                     = pos.y,
            z                     = pos.z + 1,
            rotation              = 0 + math.random(0, 360),
            look                  = (chocoStage >= 20) and look or babyLook,
            groupId               = 100,
            groupZoneId           = xi.zone.GM_HOME,
            releaseIdOnDisappear  = true,

            onTrigger = function(player, choco)
                xi.xispchocobo.chocoboTrigger(player, choco)
            end,

            onMobSpawn = function(choco)
                xi.xispal.onMobSpawn(choco, player, 1, 1)
                choco:setStatus(xi.status.NORMAL)
                choco:setAutoAttackEnabled(false)
                choco:setUnkillable(true)
            end,

            onMobRoam = function(choco)
                xi.xispal.follow(choco, player)
                -- Cute animations
                if math.random(10) <= 2 and choco:getModelId() == 1997 then
                    if math.random(2) == 1 then
                        choco:entityAnimationPacket(xi.animationString.SPECIAL_10)
                    else
                        choco:entityAnimationPacket(xi.animationString.SPECIAL_00)
                    end
                end

            end,
        })

        player:setCharVar('[XISP]chocoID', choco:getID())
        choco:setSpawn(pos.x + 1, pos.y, pos.z - 1)
        choco:spawn()
        choco:setLocalVar('[XISP]isChocobo', 1)
        choco:setLocalVar('[XISP]ownerID', player:getID())
    end
end
