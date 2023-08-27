-----------------------------------
-- Area: Jade Sepulcher
--  Mob: Raubahn
-- BCNM: The Beast Within
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
-----------------------------------

local entity = {}

entity.onMobInitialize = function(mob)
mob:addListener("ROAM_TICK", "RAUBAHN_RTICK", function(mobArg)
        if mobArg:getLocalVar("engaged") == 0 then
            local players = mobArg:getZone():getPlayers()
            for _, player in pairs(players) do
                if player:checkDistance(mobArg) < 8 then
                    local ID = zones[mobArg:getZoneID()]
                    mobArg:messageText(mobArg, ID.text.SURRENDER_STRENGTH)
                    mobArg:setLocalVar("engaged", player:getID())
                end
            end
        end
    end)

    mob:addListener("ENGAGE", "RAUBAHN_ENGAGE", function(mobArg, target)
        local ID = zones[mobArg:getZoneID()]
        if mobArg:getLocalVar("engaged") == 0 then
            mobArg:messageText(mobArg, ID.text.SOUL_DEVOURED)
            mobArg:setLocalVar("engaged", target:getID())
        end
    end)

    mob:addListener("DISENGAGE", "RAUBAHN_DISENGAGE", function(mobArg)
        local ID = zones[mobArg:getZoneID()]
        local engagedID = mobArg:getLocalVar("engaged")
        if engagedID ~= 0 then
            local player = GetPlayerByID(engagedID)
            if player:getHP() == 0 then
                mobArg:showText(mobArg, ID.text.BEAST_OF_AMBITION)
            end
        end
    end)

    mob:addListener("COMBAT_TICK", "RAUBAHN_CTICK", function(mobArg)
        local ID = zones[mobArg:getZoneID()]
        local defaultAbility =
        {
            [xi.job.BLU] = xi.jsa.AZURE_LORE,
        }

        if mobArg:getHPP() < mob:getLocalVar("specialThreshold") then
            mobArg:messageText(mobArg, ID.text.AZURE_SAVAGERYw)
            mobArg:useMobAbility(defaultAbility[mob:getMainJob()])
            mobArg:setLocalVar("specialThreshold", 0)
        end

        if mobArg:getHPP() < 20 then
            mobArg:showText(mobArg, ID.text.STRENGTH_HAS_FAILED_ME)
            mobArg:getBattlefield():win()
        end
    end)

    mob:addListener("DEATH", "RAUBAHN_DEATH", function(mobArg, killer)
        local ID = zones[mobArg:getZoneID()]
        mobArg:messageText(mobArg, ID.text.STRENGTH_HAS_FAILED_ME)
    end)

    mob:addListener("WEAPONSKILL_TAKE", "RAUBAHN_WEAPONSKILL_TAKE", function(target, user, wsid, tp, action)
        local ID = zones[target:getZoneID()]
        target:messageText(target, ID.text.SHOW_ME)
    end)

    mob:addListener("WEAPONSKILL_USE", "RAUBAHN_WEAPONSKILL_USE", function(mobArg, target, wsid, tp, action)
        local ID = zones[target:getZoneID()]
        if wsid >= 1 then -- Same message for all WS's
            mobArg:messageText(mobArg, ID.text.BLUE_MAGIC_ARSENAL)
        end
    end)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
