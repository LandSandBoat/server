-----------------------------------
-- Area: Qu'Bia_Arena
--  Mob: Anansi
-- KSNM: Come Into My Parlor
-----------------------------------

---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 25)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobSpawn = function(mob)
    mob:setBehavior(xi.behavior.NO_DESPAWN) -- Anansi doesn't despawn until all of their sons have spawned
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.POISON, { chance = 20, power = 50, duration = 40 }) -- Very powerful additional effect: poison
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        xi.magic.spell.PARALYGA,
        xi.magic.spell.SLOWGA,
        xi.magic.spell.POISONGA_II,
    }

    return spellList[math.random(1, #spellList)]
end

-- When Anansi dies, their eight sons spawn one at a time every 5 seconds after an initial 10 second delay. Anansis' body fades away after all sons have spawned.
entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local offset = mob:getID() + 1

        -- Record Anansis' death position
        local posX = mob:getXPos()
        local posY = mob:getYPos()
        local posZ = mob:getZPos()

        mob:timer(10000, function(mobArg)
            -- Spawn every 5 seconds after
            for i = 1, 8 do
                mobArg:timer((i - 1) * 5000, function(mobArg2)
                    SpawnMob(offset + i)
                    local son = GetMobByID(offset + i)
                    if not son then
                        return
                    end

                    -- Choose spawn position.
                    if i == 1 then
                        son:setPos(posX, posY, posZ)
                    else
                        son:setPos(posX + math.random(-1, 1) * 0.5, posY, posZ + math.random(-1, 1) * 0.5)
                    end

                    son:updateEnmity(player)

                    -- Despawn Anansi after the last son spawns.
                    if i == 8 then
                        mobArg2:timer(5000, function(mobArg3)
                            mobArg3:setBehavior(xi.behavior.NONE)
                        end)
                    end
                end)
            end
        end)
    end
end

return entity
