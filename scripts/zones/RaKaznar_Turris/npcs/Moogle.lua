-----------------------------------
-- Area: RaKaznar Turris
--  NPC: Seismic Tower
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    local helga   = GetServerVariable("[Domain]HelgaID")
    local helgaId = GetMobByID(helga)
    local zone    = npc:getZone()
    local pedestalTriggers = GetMobByID(helga):getLocalVar("TowerTrigger")
	local getDamage = player:getLocalVar("[Domain]Damage")

    -- Add a check so player's can't get trolled by others
    if pedestalTriggers < 3 then
        helgaId:weaknessTrigger(1)
        helgaId:addStatusEffect(xi.effect.STUN, 0, 0, 6)
		player:setLocalVar("[Domain]Damage", getDamage + 5000)
    elseif pedestalTriggers > 3 then
        local Rafflesia1 = zone:insertDynamicEntity({
            objtype     = xi.objType.MOB,
            name        = "Rafflesia",
            look        = "0x0000EA0700000000000000000000000000000000",
            x           = 720.096,
            y           = -405.501,
            z           = -488.468,
            rotation    = 129,
            groupId     = 7,
            groupZoneId = 95,

            -- Despawn adds if parent is not alive
            onMobFight = function(mob, target)
                if not mob:isAlive() then
                    DespawnMob(mob:getID())
                end
            end,

            -- Cleanup adds in case of wipe/reset
            onMobRoam = function(mob)
                DespawnMob(mob:getID())
            end,
        })

        local Rafflesia2 = zone:insertDynamicEntity({
            objtype     = xi.objType.MOB,
            name        = "Rafflesia",
            look        = "0x0000EA0700000000000000000000000000000000",
            x           = 720.125,
            y           = -405.501,
            z           = -471.696,
            rotation    = 129,
            groupId     = 7,
            groupZoneId = 95,
    
            -- Despawn adds if parent is not alive
            -- Also serves to despawn children if triggered while parent dead.
            onMobFight = function(mob, target)
                if not mob:isAlive() then
                    DespawnMob(mob:getID())
                end
            end,

            -- Cleanup adds in case of wipe/reset
            onMobRoam = function(mob)
                DespawnMob(mob:getID())
            end,
        })

        Rafflesia1:setSpawn(720.096, -405.501, -488.468, 129)
        Rafflesia2:setSpawn(720.125, -405.501, -471.696, 129)
        Rafflesia1:spawn()
        Rafflesia2:spawn()
        Rafflesia1:updateClaim(player)
        Rafflesia2:updateClaim(player)
        Rafflesia1:addStatusEffect(xi.effect.ENASPIR, 10, 0, 0)
        Rafflesia2:addStatusEffect(xi.effect.ENASPIR, 10, 0, 0)
    end

    helgaId:setLocalVar("TowerTrigger", pedestalTriggers + 1)

    npc:timer(500, function(npcArg)
        npcArg:setStatus(xi.status.INVISIBLE)
    end)

    npc:timer(25000, function(npcArg)
        if not helgaId:isAlive() then
            npcArg:setStatus(xi.status.NORMAL)
        end
    end)

end

return entity
