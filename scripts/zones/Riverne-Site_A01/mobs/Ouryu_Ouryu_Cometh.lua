-----------------------------------
-- Area: Riverne - Site A01
-- Mob: Ouryu
-- Notes: in Ouryu Cometh (Cloud Evoker)
-- !pos 184 0 344 30
-----------------------------------
mixins =
{
    require('scripts/mixins/families/flying_wyrm'),
    require('scripts/mixins/job_special')
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SLOW)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.ELEGY)
    mob:addImmunity(xi.immunity.PETRIFY)
end

entity.onMobSpawn = function(mob)
    mob:setSpellList(548)

    mob:setMod(xi.mod.UDMGRANGE, -5000)
    mob:setMod(xi.mod.UDMGMAGIC, -5000)
    mob:setMod(xi.mod.UDMGBREATH, -5000)
    mob:setMod(xi.mod.UFASTCAST, 90)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 10)
    mob:setMod(xi.mod.REFRESH, 200)

    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 53) -- Level 90 + 2 + 53 = 145 Base Weapon Damage
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.DETECTION, bit.bor(xi.detects.SIGHT, xi.detects.HEARING))
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 20)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 15)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 60)

    -- can use invincible on ground or air
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.INVINCIBLE, hpp = math.random(50, 85) },
        },
    })
end

entity.onMobEngage = function(mob)
    -- Spawn Ziryu and elementals only on mob engage (not at start of BCNM)
    local mobId = mob:getID()
    for i = 1, 4 do
        local pet = GetMobByID(mobId + i)
        if pet and not pet:isSpawned() then
            pet:spawn()
        end
    end
end

entity.onMobFight = function(mob, target)
    local drawInTable =
    {
        conditions =
        {
            mob:checkDistance(target) >= 15,
        },
        position = mob:getPos(),
    }
    utils.drawIn(target, drawInTable)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENSTONE, { damage = math.random(89, 111), chance = 10 })
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.OURYU_OVERWHELMER)
end

entity.onMobDespawn = function(mob)
    -- If Ouryu despawns then also then despawn all Ziryu
    local mobId = mob:getID()
    for i = 1, 4 do
        local pet = GetMobByID(mobId + i)
        if pet and pet:isAlive() then
            DespawnMob(mobId + i)
        end
    end
end

return entity
