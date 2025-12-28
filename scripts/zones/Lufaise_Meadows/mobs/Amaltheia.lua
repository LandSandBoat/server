-----------------------------------
-- Area: Lufaise Meadows
--   NM: Amaltheia
-----------------------------------
local ID = zones[xi.zone.LUFAISE_MEADOWS]
-----------------------------------
---@type TMobEntity
local entity = {}

local function getFollowerList(mob)
    local followers = {}
    local rams = ID.mob.TAVNAZIAN_RAM
    local sheep = ID.mob.TAVNAZIAN_SHEEP
    for _, id in pairs(rams) do
        local ram = GetMobByID(id)
        if ram then
            table.insert(followers, ram)
        end
    end

    for _, id in pairs(sheep) do
        local sheepMob = GetMobByID(id)
        if sheepMob then
            table.insert(followers, sheepMob)
        end
    end

    return followers
end

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.ELEGY)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.SLOW)
    mob:addImmunity(xi.immunity.STUN)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('holyTimer', GetSystemTime() + 30)

    -- Set up all sheep and rams to follow Amaltheia
    local followers = getFollowerList(mob)
    for _, follower in pairs(followers) do
        if follower and follower:isSpawned() then
            xi.follow.follow(follower, mob)
        end
    end

    -- Triggers Holy cast when a magic spell hits Amaltheia
    mob:addListener('MAGIC_TAKE', 'AMALTHEIA_MAGIC_TAKE', function(mobArg, caster, spell)
        mobArg:castSpell(xi.magic.spell.HOLY, mobArg:getTarget())
    end)
end

entity.onMobEngage = function(mob, target)
    mob:messageText(mob, ID.text.AMALTHEIA_TEXT + 1)
    mob:messageText(mob, ID.text.AMALTHEIA_TEXT + 2)
end

entity.onMobFight = function(mob, target)
    local holyTimer = mob:getLocalVar('holyTimer')
    if
        GetSystemTime() >= holyTimer and
        not xi.combat.behavior.isEntityBusy(mob)
    then
        mob:castSpell(xi.magic.spell.HOLY, target)
        mob:setLocalVar('holyTimer', GetSystemTime() + 30)
    end
end

entity.onMobMobskillChoose = function(mob, target)
    local tpMoves =
    {
        xi.mobSkill.RAGE_2,
        xi.mobSkill.RAM_CHARGE,
        xi.mobSkill.RUMBLE,
        xi.mobSkill.GREAT_BLEAT,
        xi.mobSkill.PETRIBREATH
    }

    return tpMoves[math.random(1, #tpMoves)]
end

return entity
