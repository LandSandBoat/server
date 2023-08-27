-----------------------------------
-- behind_the_sluices
-- !instance 25900
-----------------------------------
require('scripts/globals/instance')
require('scripts/globals/allyassist')
local ID = require('scripts/zones/Rala_Waterways_U/IDs')
-----------------------------------
local instanceObject = {}

instanceObject.registryRequirements = function(player)
    return player:hasKeyItem(xi.ki.WATERWAY_FACILITY_CRANK) and
        player:getMissionStatus(xi.mission.log_id.SOA) == 2
end

instanceObject.entryRequirements = function(player)
    return player:hasKeyItem(xi.ki.WATERWAY_FACILITY_CRANK) -- TODO: Past this mission
end

instanceObject.onInstanceCreated = function(instance)
    -- TODO: SpawnMob: mob <17838151> not found (luautils::SpawnMob:1358)
    for i = 0, 5 do
        SpawnMob(ID.mob.ARCIELA_BTS + i, instance)
    end

    -- TODO: Fill in skillchain information for new mob moves
    -- TODO: Do the enemies send "Readies WS..." message?

    -- TODO: BG-WIKI:
    -- You fight alongside Arciela!
    -- Arciela will buff herself with Stoneskin, Protect V, and Shell V.
    -- Arciela will engage the enemies on her own after a player readies their battle stance (takes weapons out), but will stay put until then.
    -- Arciela can hold her own well, but will require healing.
    -- You fight against four enemies.

    -- The Keeper (SCH/BLM)
    -- Uses Gust Slash, Cyclone, Aeolian Edge, and casts single target Kaustra.
    -- He is the most resistant to damage.
    -- Recommended to fight last.

    -- Mistdagger (NIN)
    -- Casts Ninjutsu, and has access to all Katana weapon skills.

    -- The Briars (Galka) (WAR)
    -- Has access to all Great Axe weapon skills, but is likely to use Full Break and Fell Cleave.

    -- The Briars (Elvaan) (RDM/BLM)
    -- Casts -aga 3 black magic and spells like Slow II.

    -- All four enemies run to a random target to perform weapon skills, regardless of hate.
    -- This causes skillchains to happen on players so take care.
    -- Alter Ego Trusts may be summoned in this fight.
    -- At 119 this fight is not a problem with 5 Trusts.
end

instanceObject.onInstanceCreatedCallback = function(player, instance)
    xi.instance.onInstanceCreatedCallback(player, instance)
end

instanceObject.afterInstanceRegister = function(player)
    player:messageSpecial(ID.text.KEYITEM_LOST, xi.ki.WATERWAY_FACILITY_CRANK)
    player:delKeyItem(xi.ki.WATERWAY_FACILITY_CRANK)
end

instanceObject.onInstanceTimeUpdate = function(instance, elapsed)
    -- Custom MobSkill logic for enemies
    local enemiesDefeated = 0

    -- TODO: Fixme to work with Trusts
    local chars = instance:getChars()
    local mobs = instance:getMobs()

    for _, mob in pairs(mobs) do
        -- Mobs
        if mob:getID() > ID.mob.ARCIELA_BTS then
            if mob:isDead() then
                enemiesDefeated = enemiesDefeated + 1
            end

            if enemiesDefeated == 4 then
                instance:complete()
            end

            local mistDaggerID = ID.mob.ARCIELA_BTS + 2

            local wsState = mob:getLocalVar('CUSTOM_WS_STATE')
            switch (wsState): caseof
            {
                -- Normal mode
                [0] = function()
                    -- NOTE: Regular WSs might get through during low HP
                    local target = mob:getTarget()
                    if target and mob:getTP() >= 1000 then
                        -- Turn off Mistdaggers STANDBACK
                        if mob:getID() == mistDaggerID then
                            mob:setMobMod(xi.mobMod.HP_STANDBACK, 0)
                        end

                        mob:setLocalVar('CUSTOM_WS_STATE', 1)
                    end
                end,

                -- Set new target
                [1] = function()
                    local newTarget = utils.randomEntry(chars)
                    if newTarget then
                        mob:addEnmity(newTarget, 0, 1800) -- Same VE as Provoke
                        mob:updateTarget()
                        mob:setLocalVar('CUSTOM_WS_STATE', 2)
                    end
                end,

                -- Get in range and try to WS that target
                [2] = function()
                    local target = mob:getTarget()
                    if mob:checkDistance(target) < 3 then
                        mob:useMobAbility()
                        mob:setLocalVar('CUSTOM_WS_STATE', 0)

                        -- Reset Mistdaggers STANDBACK
                        if mob:getID() == mistDaggerID then
                            mob:setMobMod(xi.mobMod.HP_STANDBACK, 100)
                        end
                    end
                end,
            }
        else -- Arciela
            if instance:getLocalVar("FIGHT_STARTED") == 1 then
                xi.ally.startAssist(mob, xi.ally.ASSIST_RANDOM)
            end
        end
    end
end

instanceObject.onInstanceFailure = function(instance)
    local chars = instance:getChars()
    for i, v in pairs(chars) do
        v:setPos(-529.361, -7.000, 59.988, 0, 258)
    end
end

instanceObject.onInstanceProgressUpdate = function(instance, progress)
end

instanceObject.onInstanceComplete = function(instance)
    local chars = instance:getChars()
    for i, v in pairs(chars) do
        v:startEvent(1000)

        local onThisMission = v:getCurrentMission(xi.mission.log_id.SOA) == xi.mission.id.soa.BEHIND_THE_SLUICES
        local onThisFight = v:getMissionStatus(xi.mission.log_id.SOA) == 2
        if onThisMission and onThisFight then
            v:setMissionStatus(xi.mission.log_id.SOA, 3)
        end
    end
end

return instanceObject
