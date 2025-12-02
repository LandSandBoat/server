-----------------------------------
-- Area: Hazhalm Testing Grounds
--   NM: Motsognir (Einherjar)
-- Notes: Spawns with 12 demons
-- Cannot be damaged/enfeeb by any source, all spells/attacks show as "No effect", 0 dmg or "Resist"
-- Each dead demon reduces Motsognir's HP by 1/12th of its max HP
-- When all demons are dead, Motsognir despawns after 10 seconds
-- Uses BLM spells with no standback every 20 seconds
-- Uses all Dvergr moves but the selection expands as HP goes down. Hellsnap wakes all demons.
-- Uses a TP move every 16 seconds, regardless of HP
-- Demons superlink with Motsognir and vice versa
-----------------------------------
mixins =
{
    require('scripts/mixins/draw_in'),
}
local ID = zones[xi.zone.HAZHALM_TESTING_GROUNDS]
-----------------------------------

---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.einherjar.onBossInitialize(mob)
    mob:addMod(xi.mod.UDMGPHYS, -10000)
    mob:addMod(xi.mod.UDMGMAGIC, -10000)
    mob:addMod(xi.mod.UDMGRANGE, -10000)
    mob:addMod(xi.mod.UDMGBREATH, -10000)
    mob:setMod(xi.mod.REGAIN, 0)

    -- TODO: There might be a status effect that does all of this...
    mob:addImmunity(xi.immunity.ADDLE)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.SLOW)
    mob:addImmunity(xi.immunity.POISON)
    mob:addImmunity(xi.immunity.ELEGY)
    mob:addImmunity(xi.immunity.REQUIEM)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.ASPIR)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.DISPEL)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.PLAGUE)

    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
    mob:setMobMod(xi.mobMod.SUPERLINK, mob:getID())
end

entity.onMobFight = function(mob, target)
    if mob:getLocalVar('nextTpMove') <= GetSystemTime() then
        mob:setMobAbilityEnabled(true)
        mob:setTP(3000)
    else
        mob:setMobAbilityEnabled(false)
    end

    if mob:getLocalVar('despawning') == 1 then
        return
    end

    -- Motsognir despawns when all 12 demons are dead
    -- Its HP is reduced by 1/12th of its max HP for each demon that dies
    local demonsAlive = 0
    for i = ID.mob.HERVARTH, ID.mob.HADDING_THE_YOUNGER do
        local demon = GetMobByID(i)
        if demon and demon:isAlive() then
            demonsAlive = demonsAlive + 1
        end
    end

    local maxHP = mob:getMaxHP()
    local expectedHP = maxHP * (demonsAlive / 12)
    if mob:getHP() > expectedHP then
        mob:setHP(math.max(expectedHP, 1))
    end

    -- Timer so Motsognir doesn't despawn before the demons nameplates are gone
    if demonsAlive == 0 then
        mob:setLocalVar('despawning', 1)
        mob:timer(10000, function()
            DespawnMob(mob:getID())
        end)
    end
end

entity.onMobMobskillChoose = function(mob, target)
    -- Motsognir gains access to more TP moves as its HP goes down
    local mobskillList =
    {
        xi.mobSkill.HELLSNAP,
        xi.mobSkill.HELLCLAP,
        xi.mobSkill.CACKLE,
    }

    local mobHPP = mob:getHPP()

    if mobHPP <= 75 then
        table.insert(mobskillList, xi.mobSkill.NECROBANE)
        table.insert(mobskillList, xi.mobSkill.NECROPURGE)
    end

    if mobHPP <= 50 then
        table.insert(mobskillList, xi.mobSkill.BILGESTORM)
    end

    if mobHPP <= 25 then
        table.insert(mobskillList, xi.mobSkill.THUNDRIS_SHRIEK)
    end

    return mobskillList[math.random(1, #mobskillList)]
end

entity.onMobWeaponSkill = function(target, mob, skill)
    -- Wake all demons on Hellsnap, no known range limit
    if skill:getID() == xi.mobSkill.HELLSNAP then
        for i = ID.mob.HERVARTH, ID.mob.HADDING_THE_YOUNGER do
            local demon = GetMobByID(i)
            if demon and demon:isAlive() then
                demon:wakeUp()
            end
        end
    end

    mob:setLocalVar('nextTpMove', GetSystemTime() + 16)
end

entity.onMobEngage = function(mob)
    -- First TP move about 5 seconds in, then every 16 seconds
    mob:setLocalVar('nextTpMove', GetSystemTime() + 5)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('despawning', 0)
    if mob:getLocalVar('[ein]chamber') == 0 then -- fallback for testing without einherjar context
        for i = ID.mob.HERVARTH, ID.mob.HADDING_THE_YOUNGER do
            local demon = GetMobByID(i)
            if demon and not demon:isSpawned() then
                demon:setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos(), mob:getRotPos())
                demon:spawn()
                local target = mob:getTarget()
                if target then
                    demon:updateEnmity(target)
                end
            end
        end
    end
end

return entity
