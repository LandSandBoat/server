-----------------------------------
-- Area: Boneyard Gully
-- Mob: Gwyn Ap Knudd
-- ENM: Totentanz
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
end

entity.onMobEngaged = function(mob)
    mob:setLocalVar("timer", os.time() + math.random(15, 30))
    mob:getBattlefield():setLocalVar("undeadControl", 1)
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    for i = 1, 3 do
        local undead = GetMobByID(mob:getID() + i)
        local ability = math.random(478, 479)

        if undead:isAlive() then
            undead:queue(0, function(undeadArg)
                undeadArg:useMobAbility(ability, undeadArg:getTarget())
            end)
        end
    end
end

entity.onMobMagicPrepare = function(mob, target, spell)
    mob:timer(4000, function(mobArg)
        for i = 4, 9 do
            local undead = GetMobByID(mobArg:getID() + i)

            if undead:isAlive() then
                if spell:getID() ~= 245 and spell:getID() ~= 247 then -- mimic aga spell but 1 tier lower
                    undead:castSpell(spell:getID() - 1, undead:getTarget())
                else
                    undead:castSpell(spell:getID(), undead:getTarget())
                end
            end
        end
    end)
end

entity.onMobFight = function(mob, target)
    if mob:getLocalVar("timer") < os.time() then
        mob:setLocalVar("timer", os.time() + math.random(15, 30))
        mob:setLocalVar("addControl", 0)
        local control = false

        for i = 1, 9 do
            if not GetMobByID(mob:getID() + i):isAlive() then
                control = true
            end
        end

        while control do
            local undead = GetMobByID(mob:getID() + math.random(1, 9))
            if not undead:isAlive() then
                undead:setHP(undead:getMaxHP())
                undead:resetAI()
                undead:hideName(false)
                undead:setUntargetable(false)
                undead:updateEnmity(target)
                control = false
            end
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    -- player won the battle so cleanup by killing undead and allowing despawn
    if mob:getLocalVar("cleanupUndead") == 0 then
        for i = 1, 9 do
            local undead = GetMobByID(mob:getID() + i)
            undead:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NONE))

            if undead:isAlive() then
                undead:setHP(0)
            end
        end

        mob:setLocalVar("cleanupUndead", 1)
    end
end

entity.onMobDespawn = function(mob, player, optParams)
    -- player lost without killing boss so despawn undead manually
    if mob:getLocalVar("cleanupUndead") == 0 then
        for i = 1, 9 do
            local undead = GetMobByID(mob:getID() + i)

            if undead:isSpawned() then
                undead:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NONE))
                DespawnMob(undead:getID())
            end
        end

        mob:setLocalVar("cleanupUndead", 1)
    end
end

return entity
