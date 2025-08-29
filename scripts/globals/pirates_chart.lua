-----------------------------------
-- Pirates Chart Quest (hidden)
-----------------------------------
-- !additem 1874 -- Pirates Chart
-- qm4 : !pos -168.6 4 -131.4 103
-----------------------------------
local valkID = zones[xi.zone.VALKURM_DUNES]
-----------------------------------

xi = xi or {}
xi.piratesChart = xi.piratesChart or {}

xi.piratesChart.onTrade = function(player, npc, trade)
    if player:getPartySize() > 3 then
        player:messageSpecial(valkID.text.TOO_MANY_IN_PARTY, 3)
    elseif player:checkSoloPartyAlliance() == 2 then
        player:messageSpecial(valkID.text.ALLIANCE_NOT_ALLOWED)
    elseif
        npc:getStatus() == xi.status.NORMAL and
        npcUtil.tradeHasExactly(trade, xi.item.PIRATES_CHART)
    then
        player:messageSpecial(valkID.text.RETURN_TO_SEA, xi.item.PIRATES_CHART)
        player:startEvent(14, 0, 0, 0, 3)
    end
end

xi.piratesChart.onEventUpdate = function(player, csid, option, npc)
    if csid == 14 and option == 0 then
        player:confirmTrade()

        -- Change music for party and remove buffs
        local party = player:getParty()
        for _, member in pairs(party) do
            member:changeMusic(0, 136)
            member:changeMusic(1, 136)
            member:changeMusic(2, 136)
            member:changeMusic(3, 136)
            member:delStatusEffectsByFlag(xi.effectFlag.DISPELABLE)
            member:addStatusEffect(xi.effect.LEVEL_RESTRICTION, 20, 0, 0, 0, 0)
        end
    end
end

xi.piratesChart.onEventFinish = function(player, csid, option, npc)
    if csid == 14 and option == 0 then
        local panicTaru  = GetNPCByID(valkID.npc.PIRATE_CHART_TARU)
        local shimmering = GetNPCByID(valkID.npc.SHIMMERING_POINT)
        local barnacle   = GetNPCByID(valkID.npc.BARNACLED_BOX)

        local mobs =
        {
            valkID.mob.HOUU_THE_SHOALWADER,
            valkID.mob.BEACH_MONK,
            valkID.mob.HEIKE_CRAB,
        }

        if
            not panicTaru or
            not shimmering or
            not barnacle
        then
            return
        end

        -- Start range checking for out-of-range messages

        -- Setup starting conditions
        panicTaru:setStatus(xi.status.NORMAL)
        panicTaru:setAnimation(xi.animation.NONE)
        shimmering:setStatus(xi.status.NORMAL)

        -- Handle taru messages and emotes

        npc:timer(50000, function(npcArg)
            local params = {}

            params.timeLimit = 600 -- 10 minutes

            params.onLose = function(member)
                member:delStatusEffect(xi.effect.LEVEL_RESTRICTION)
                member:changeMusic(0, 0)
                member:changeMusic(1, 0)
                member:changeMusic(2, 101)
                member:changeMusic(3, 102)
            end

            params.cleanUp = function()
                shimmering:setStatus(xi.status.DISAPPEAR)
                panicTaru:setStatus(xi.status.DISAPPEAR)
                panicTaru:setAnimation(xi.animation.NONE)
            end

            -- Start confrontation
            xi.confrontation.start(player, npc, mobs, params)
        end)
    end
end

xi.piratesChart.barnacledBoxOnTrigger = function(player, npc)
    -- Remove music
    -- Crate animations
    -- Distribute rewards
end

xi.piratesChart.onMobFight = function(mob, target)
    -- 2hr and temp item logic
end

xi.piratesChart.onMobDeath = function(mob, player, optParams)
    -- check if last mob to die, move box, trigger win conditions
end
