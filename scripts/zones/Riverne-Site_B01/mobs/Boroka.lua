-----------------------------------
-- Area: Riverne - Site B01
--   NM: Boroka
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.BIND)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 25)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, { specials = { { id = xi.jsa.SOUL_VOICE, hpp = 99, cooldown = 300 } } })
end

entity.onMobFight = function(mob, target)
    local hoofVolley = mob:getLocalVar('hoofVolley')
    if hoofVolley == 1 and not xi.combat.behavior.isEntityBusy(mob) then
        mob:useMobAbility(xi.mobSkill.HOOF_VOLLEY)
        mob:setLocalVar('hoofVolley', 0)
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.WEIGHT, { power = 50 })
end

entity.onMobMobskillChoose = function(mob, target)
    local tpList =
    {
        xi.mobSkill.BACK_HEEL_1,
        xi.mobSkill.JETTATURA_1,
        xi.mobSkill.NIHILITY_SONG_1,
        xi.mobSkill.CHOKE_BREATH_1,
        xi.mobSkill.FANTOD_1,
    }

    return tpList[math.random(1, #tpList)]
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.FOE_REQUIEM_V,     30 },
        [ 2] = { xi.magic.spell.BATTLEFIELD_ELEGY, 10 },
        [ 3] = { xi.magic.spell.MAGES_BALLAD_II,   10 },
        [ 4] = { xi.magic.spell.HORDE_LULLABY,     10 },
        [ 5] = { xi.magic.spell.QUICK_ETUDE,       10 },
        [ 6] = { xi.magic.spell.ARMYS_PAEON_IV,    10 },
        [ 7] = { xi.magic.spell.ADVANCING_MARCH,    5 },
        [ 8] = { xi.magic.spell.VALOR_MINUET_III,   5 },
        [ 9] = { xi.magic.spell.KNIGHTS_MINNE_III,  5 },
        [10] = { xi.magic.spell.DEXTROUS_ETUDE,     5 },
    }

    local roll = math.random(1, 100)
    local sum  = 0

    for i = 1, #spellList do
        sum = sum + spellList[i][2]
        if roll <= sum then
            return spellList[i][1]
        end
    end
end

-- Follows up every weapon skill with Hoof Volley
entity.onMobWeaponSkill = function(mob, target, skill)
    if skill:getID() ~= xi.mobSkill.HOOF_VOLLEY then
        mob:setLocalVar('hoofVolley', 1)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.BOROKA_BELEAGUERER)
    mob:setRespawnTime(math.random(75600, 86400)) -- 21-24 hour respawn
end

return entity
