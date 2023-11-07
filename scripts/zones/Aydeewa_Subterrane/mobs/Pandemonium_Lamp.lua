-----------------------------------
-- Area: Aydeewa Subterrane
--  Mob: Pandemonium Warden Pet
-----------------------------------
local ID = zones[xi.zone.AYDEEWA_SUBTERRANE]
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
end

entity.onMobMagicPrepare = function(mob, target, spell)
    -- Don't use AoE elemental magic, choose random other tier 4 or 5
    if
        spell:getID() >= xi.magic.spell.FIRAGA and
        spell:getID() <= xi.magic.spell.WATERGA_V
    then
        local newSpell = xi.magic.spell.FIRE + 5 * math.random(1, 6) - math.random(1, 2)
        return newSpell
    end
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MAX, -1)
    mob:setMobMod(xi.mobMod.NO_DROPS, 1)
    mob:setMobMod(xi.mobMod.EXP_BONUS, -101)
    mob:setMod(xi.mod.SLEEPRES, 100)
    mob:setMod(xi.mod.LULLABYRES, 100)
end

entity.onMobEngaged = function(mob, target)
    local pw = GetMobByID(ID.mob.PANDEMONIUM_WARDEN)
    if not pw:isEngaged() then
        pw:engage(target:getTargID()) -- Engage via the zone's local ID of the Lamp's target
    end

    -- 6:34 to 6:46 in this video: https://www.youtube.com/watch?v=T_Us2Tmlm-E
    -- shows approx 12-second delay on astral flow
    mob:timer(12000, function(mobArg)
        local abilityID = 0
        local modelID = mobArg:getModelId()
        switch (modelID) : caseof
        {
            [791] = function() -- Carbuncle
                        abilityID = 919
                    end,
            [792] = function() -- Fenrir
                        abilityID = 839
                    end,
            [793] = function() -- Ifrit
                        abilityID = 913
                    end,
            [794] = function() -- Titan
                        abilityID = 914
                    end,
            [795] = function() -- Leviathan
                        abilityID = 915
                    end,
            [796] = function() -- Garuda
                        abilityID = 916
                    end,
            [797] = function() -- Shiva
                        abilityID = 917
                    end,
            [798] = function() -- Ramuh
                        abilityID = 918
                    end,
        }
        if abilityID > 0 then
            -- These changes reduce dmg greatly for a well-geared TANK, but will definitely still murder a non-tank
            -- for astral flow to scale better with mdef. Resets on mob spawn.
            mobArg:setMod(xi.mod.MATT, 0)
            -- for astral flow to scale dmg/acc for player INT values
            mobArg:setMod(xi.mod.INT, -30)
            -- for astral flow to partial resist better when compared to player meva/resistances
            mobArg:setMod(xi.mod.MACC, -50)

            mobArg:useMobAbility(abilityID)

            mobArg:timer(2000, function(mobArg2)
                mobArg2:setUnkillable(false)
                mobArg2:setHP(0)
            end)
        end
    end)
end

entity.onMobDeath = function(mob, player, isKiller)
    -- cleanup quickly since spawning is blocked until mob is fully despawned, but this runs for everyone in the party, so wrap in if-check
    if mob:isSpawned() then
        DespawnMob(mob:getID())
    end
end

return entity
