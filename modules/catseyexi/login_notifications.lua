---------------------------------
-- CatsEyeXI Custom NPCs
-----------------------------------
local m = Module:new("login_notifications")

m:addOverride("xi.player.onGameIn", function(player, firstLogin, zoning)
    if not zoning then
    	-- Send a system message when players come online.
    	if player:getCharVar("NoOnlineNotification") ~= 1 then
    	    player:PrintToArea(string.format("%s has come online!", player:getName()), xi.msg.area.SYSTEM_2);
    	end
	
        -- things checked ONLY during logon go here
        if firstLogin then
            CharCreate(player)
        end
    else
        -- things checked ONLY during zone in go here
    end

    -- apply mods from gearsets (scripts/globals/gear_sets.lua)
    xi.gear_sets.checkForGearSet(player)

    -- god mode
    if player:getCharVar("GodMode") == 1 then
        player:addStatusEffect(xi.effect.MAX_HP_BOOST, 1000, 0, 0)
        player:addStatusEffect(xi.effect.MAX_MP_BOOST, 1000, 0, 0)
        player:addStatusEffect(xi.effect.MIGHTY_STRIKES, 1, 0, 0)
        player:addStatusEffect(xi.effect.HUNDRED_FISTS, 1, 0, 0)
        player:addStatusEffect(xi.effect.CHAINSPELL, 1, 0, 0)
        player:addStatusEffect(xi.effect.PERFECT_DODGE, 1, 0, 0)
        player:addStatusEffect(xi.effect.INVINCIBLE, 1, 0, 0)
        player:addStatusEffect(xi.effect.ELEMENTAL_SFORZO, 1, 0, 0)
        player:addStatusEffect(xi.effect.MANAFONT, 1, 0, 0)
        player:addStatusEffect(xi.effect.REGAIN, 300, 0, 0)
        player:addStatusEffect(xi.effect.REFRESH, 99, 0, 0)
        player:addStatusEffect(xi.effect.REGEN, 99, 0, 0)
        player:addMod(xi.mod.RACC, 2500)
        player:addMod(xi.mod.RATT, 2500)
        player:addMod(xi.mod.ACC, 2500)
        player:addMod(xi.mod.ATT, 2500)
        player:addMod(xi.mod.MATT, 2500)
        player:addMod(xi.mod.MACC, 2500)
        player:addMod(xi.mod.RDEF, 2500)
        player:addMod(xi.mod.DEF, 2500)
        player:addMod(xi.mod.MDEF, 2500)
        player:addHP(50000)
        player:setMP(50000)
    end

    -- !immortal
    if player:getCharVar("Immortal") == 1 then
        player:setUnkillable(true)
    end

    -- !hide
    if player:getCharVar("GMHidden") == 1 then
        player:setGMHidden(true)
    end

    -- remember time player zoned in (e.g., to support zone-in delays)
    player:setLocalVar("ZoneInTime", os.time())

    -- Slight delay to ensure player is fully logged in
    player:timer(2500, function(playerArg)
        -- Login Campaign rewards points once daily
        xi.events.loginCampaign.onGameIn(playerArg)
    end)
end)

return m 