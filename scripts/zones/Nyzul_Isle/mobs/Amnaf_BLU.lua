-----------------------------------
-- Area: Nyzul Isle (Path of Darkness)
--  Mob: Amnaf BLU
-----------------------------------
local ID = zones[xi.zone.NYZUL_ISLE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    local instance = mob:getInstance()
    if not instance then
        return
    end

    -- Stage 2 Adjustments
    if instance:getProgress() >= 10 then
        -- Don't let Amnaf wander back to the original spawn position
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)

        -- Stage 2 starts at 50%
        local hp = mob:getHP()
        mob:setHP(hp / 2)

        -- Stage 2 Position
        mob:setPos(499, 0, -491, 66)

        -- Stage 2 AI Flag
        mob:setLocalVar('SegmentChanged', 1)
    end

    mob:setLocalVar('DespawnSignal', 0)
    mob:setUnkillable(true)

    mob:addListener('WEAPONSKILL_STATE_ENTER', 'WS_START_MSG', function(mobArg, skillID)
        -- Circle Blade
        if skillID == 38 then
            mobArg:showText(mobArg, ID.text.I_WILL_SINK_YOUR_CORPSES)
        end
    end)
end

entity.onMobEngage = function(mob, target)
    local instance = mob:getInstance()

    -- Relax movement lock
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)

    -- Stage AI flags
    local form       = mob:getLocalVar('SegmentChanged')
    local form1Gears = mob:getLocalVar('Form1Gears')
    local form2Gears = mob:getLocalVar('Form2Gears')

    -- 4 gears spawn on Stage 1 of the Fight
    if form1Gears == 0 then
        mob:showText(mob, ID.text.FORMATION_GELINCIK)
        SpawnMob(ID.mob.IMPERIAL_GEAR_OFFSET, instance):updateEnmity(target)
        SpawnMob(ID.mob.IMPERIAL_GEAR_OFFSET + 1, instance):updateEnmity(target)
        SpawnMob(ID.mob.IMPERIAL_GEAR_OFFSET + 2, instance):updateEnmity(target)
        SpawnMob(ID.mob.IMPERIAL_GEAR_OFFSET + 3, instance):updateEnmity(target)
        mob:setLocalVar('Form1Gears', 1)
    end

    -- 4 more gears spawn on Stage 2 of the Fight
    if
        form == 1 and
        form2Gears == 0
    then
        mob:showText(mob, ID.text.SURRENDER)

        local gearList =
        {
            ID.mob.IMPERIAL_GEAR_OFFSET,
            ID.mob.IMPERIAL_GEAR_OFFSET + 1,
            ID.mob.IMPERIAL_GEAR_OFFSET + 2,
            ID.mob.IMPERIAL_GEAR_OFFSET + 3,
        }

        for _, gearId in ipairs(gearList) do
            local gear = SpawnMob(gearId, instance)

            if gear then
                gear:updateEnmity(target)
                gear:setLocalVar('Form2Gears', 1)
            end
        end
    end
end

entity.onMobFight = function(mob, target)
    local segment = mob:getLocalVar('SegmentChanged')

    if mob:getHPP() <= 30 and mob:getLocalVar('RenameThisVar') == 0 then
        mob:showText(mob, ID.text.CURSED_ESSENCES)
        -- Azure Lore (or Chain Affinity?) needs to happen here followed by ws+cast. https://youtu.be/7jsXnwkqMM4?t=4m4s
        mob:setLocalVar('RenameThisVar', 1)

    -- At 50% and 20% respectively, Amnaf disappears and the fight advances to the next stage
    elseif
        (mob:getHPP() <= 50 and segment == 0) or
        (mob:getHPP() <= 20 and segment == 1)
    then
        if segment == 0 then -- It was less duplicate code to just check segment again.
            mob:showText(mob, ID.text.UGH)
        elseif segment == 1 then
            mob:showText(mob, ID.text.CANNOT_WIN)
        end

        if mob:getLocalVar('DespawnSignal') == 0 then
            mob:setLocalVar('DespawnSignal', 1)
            local instance = mob:getInstance()
            if not instance then
                return
            end

            instance:setProgress(instance:getProgress() + 10)
        end
    end
end

entity.onSpellPrecast = function(mob, spell)
    -- Hysteric Barrage
    if spell == 641 then
        mob:showText(mob, ID.text.AWAKEN)
    -- Tail Slap
    elseif spell == 640 then
        mob:showText(mob, ID.text.MANIFEST)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    local instance = mob:getInstance()
    if not instance then
        return
    end

    instance:setProgress(instance:getProgress() + 10)
end

return entity
