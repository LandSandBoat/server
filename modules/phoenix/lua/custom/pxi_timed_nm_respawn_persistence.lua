-----------------------------------
-- Timed NM Respawn Persistence
-- Saves respawn deadlines in server variables so downtime counts toward the window.
-- DESPAWN saves after base and era scripts roll. SPAWN clears the deadline.
-- Restore during onMobInitialize so pending timers block the boot spawn.
--
-- The 60 second floor prevents a short restored timer from surviving into the
-- next death and respawning the NM during its three second fade, skipping despawn hooks.
--
-- Alive NMs have no saved deadline. Their initialize rolls still apply after
-- restart, as in base LSB (up to five days for Ash Dragon). Restoring alive
-- state requires separate persistence.
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('pxi_timed_nm_respawn_persistence')

-- The longest prefixed key is 33 characters. server_variables.name allows 50.
local varPrefix = '[PXI][TNM]'

-----------------------------------
-- Single entity NMs
-- Open world timed NMs with windows of at least one hour. Excludes quest, mission,
-- battlefield, lottery, spawn slot, popped, dynamic and instanced content.
-- Load the era module first so the saved window replaces its initialize roll.
-----------------------------------
local timedNMs =
{
    -- { zone script folder, { mob file names } }
    { 'Arrapago_Reef',          { 'Lamia_No19', 'Lamie_No9' } },
    { 'Attohwa_Chasm',          { 'Tiamat', 'Xolotl' } },
    { 'Batallia_Downs',         { 'Ahtu', 'Weeping_Willow' } },
    { 'Bostaunieux_Oubliette',  { 'Bloodsucker_NM', 'Drexerion_the_Condemned', 'Phanduron_the_Condemned' } },
    { 'Caedarva_Mire',          { 'Khimaira' } }, -- The zone reschedules him at boot. See the section below.
    { 'Cape_Teriggan',          { 'Kreutzet' } },
    { 'Castle_Zvahl_Baileys',   { 'Duke_Haborym', 'Grand_Duke_Batym', 'Marquis_Allocen', 'Marquis_Amon' } },
    { 'Den_of_Rancor',          { 'Tonberry_Pontifex' } },
    { 'Eastern_Altepa_Desert',  { 'Cactrot_Rapido', 'Centurio_XII-I' } },
    { 'FeiYin',                 { 'Capricious_Cassie' } },
    { 'Garlaige_Citadel',       { 'Old_Two-Wings', 'Serket', 'Skewer_Sam' } },
    { 'Gusgen_Mines',           { 'Juggler_Hecatomb' } },
    { 'Gustav_Tunnel',          { 'Bune' } },
    { 'Ifrits_Cauldron',        { 'Ash_Dragon' } },
    { 'Inner_Horutoto_Ruins',   { 'Maltha' } },
    { 'Jugner_Forest',          { 'Fraelissa', 'Meteormauler_Zhagtegg' } },
    { 'King_Ranperres_Tomb',    { 'Vrtra' } },
    { 'Kuftal_Tunnel',          { 'Guivre' } },
    { 'Labyrinth_of_Onzozo',    { 'Mysticmaker_Profblix' } },
    { 'Meriphataud_Mountains',  { 'Coo_Keja_the_Unseen', 'Waraxe_Beak' } },
    { 'Misareaux_Coast',        { 'Upyri' } },
    { 'Mount_Zhayolm',          { 'Cerberus' } }, -- The zone reschedules him at boot. See the section below.
    { 'Ordelles_Caves',         { 'Morbolger' } },
    { 'Palborough_Mines',       { 'NoMho_Crimsonarmor' } },
    { 'Pashhow_Marshlands',     { 'BoWho_Warmonger' } },
    { 'Phomiuna_Aqueducts',     { 'Tres_Duendes' } },
    { 'Promyvion-Dem',          { 'Satiator' } },
    { 'Promyvion-Holla',        { 'Cerebrator' } },
    { 'Promyvion-Mea',          { 'Coveter' } },
    { 'Quicksand_Caves',        { 'Antican_Consul', 'Proconsul_XII' } },
    { 'Riverne-Site_B01',       { 'Boroka' } },
    { 'RoMaeve',                { 'Shikigami_Weapon' } },
    { 'Rolanberry_Fields',      { 'Simurgh' } },
    { 'Sauromugue_Champaign',   { 'Roc' } },
    { 'Sea_Serpent_Grotto',     { 'Ocean_Sahagin' } },
    { 'Temple_of_Uggalepih',    { 'Manipulator' } },
    { 'The_Boyahda_Tree',       { 'Ancient_Goobbue' } },
    { 'The_Eldieme_Necropolis', { 'Anemone' } },
    { 'The_Shrine_of_RuAvitau', { 'Faust', 'Mother_Globe' } },
    { 'Toraimarai_Canal',       { 'Oni_Carcass' } },
    { 'Uleguerand_Range',       { 'Jormungand', 'Mountain_Worm_NM' } },
    { 'VeLugannon_Palace',      { 'Zipacna' } },
    { 'Wajaom_Woodlands',       { 'Hydra' } },
    { 'Western_Altepa_Desert',  { 'King_Vinegarroon' } },
    { 'Yhoator_Jungle',         { 'Bisque-heeled_Sunberry', 'Bright-handed_Kunberry', 'Woodland_Sage' } },
    { 'Yuhtunga_Jungle',        { 'Meww_the_Turtlerider' } },
}

-- TODO: add these live stronghold NMs once Besieged is implemented.
-- Lamie_No7 and Merrow_No5 need xi.module.ensureTable because they have no scripts.
--   Arrapago Reef  Lamie_No7, Medusa, Merrow_No5
--   Halvung        Dorgerwor_the_Astute
--   Mamook         Darting_Kachaal_Ja, Dragonscaled_Bugaal_Ja,
--                  Gulool_Ja_Ja, Hundredfaced_Hapool_Ja
-- Hundredfaced Hapool Ja shares his handler with four Utsusemi clones.
-- Only zones[xi.zone.MAMOOK].mob.HUNDRED_FACE_HAPOOL_JA gets a window.

-- TODO: add WotG NMs when enabled. Adding overrides for their missing entities would cause errors.
-- This list is incomplete.
--   Arrapago Reef          Euryale
--   Caedarva Mire          Aynu-kaysey
--   Eastern Altepa Desert  Sabotender_Corrido
--   FeiYin                 Jenglot, Sluagh
--   Fort Ghelsba           Kegpaunch_Doshgnosh
--   Garlaige Citadel       Frogamander
--   Halvung                Copper_Borer
--   King Ranperres Tomb    Ankou
--   Korroloka Tunnel       Thoon
--   Lower Delkfutts Tower  Tyrant
--   Maze of Shakhrami      Gloombound_Lurker
--   Newton Movalpolos      Sword_Sorcerer_Solisoq
--   Oldton Movalpolos      Bugbear_Muscleman
--   Rolanberry Fields      Ravenous_Crawler
--   Sanctuary of ZiTah     Bastet, Huwasi
--   Toraimarai Canal       Brazen_Bones
--   West Ronfaure          Amanita
--   Yhoator Jungle         Acolnahuacatl

-- TODO: Padfoot's five copies share a 21 to 24 hour window, but zone boot forces them up.
-- Restoring it needs a boot depop. Fix claim shield's timer canceling that despawn first.

for _, entry in ipairs(timedNMs) do
    local zoneName = entry[1]

    for _, mobName in ipairs(entry[2]) do
        m:addOverride(string.format('xi.zones.%s.mobs.%s.onMobInitialize', zoneName, mobName), function(mob)
            super(mob)

            local mobId = mob:getID()

            -- The two Anemones need separate keys to avoid overwriting each other's window.
            local varName = varPrefix .. (mobName == 'Anemone' and (mobName .. mobId) or mobName)

            -- Save the normal window before setRespawnTime replaces it.
            -- Restore it on spawn so the saved remainder does not become permanent.
            local baseWindow = GetMobRespawnTime(mobId)

            mob:addListener('DESPAWN', 'PXI_TNM_DESPAWN', function(mobArg)
                local remaining = mobArg:getRespawnTime()
                if remaining > 0 then
                    SetServerVariable(varName, GetSystemTime() + remaining)
                end
            end)

            -- Clear the deadline and restore the normal window even for scripts that never reroll.
            mob:addListener('SPAWN', 'PXI_TNM_SPAWN', function(mobArg)
                SetServerVariable(varName, 0)

                if baseWindow > 0 then
                    mobArg:setRespawnTime(baseWindow)
                end
            end)

            -- Register before the boot spawn pass, which skips pending respawns.
            local deadline = GetServerVariable(varName)
            if deadline > 0 then
                mob:setRespawnTime(math.max(deadline - GetSystemTime(), 60))
            end
        end)
    end
end

-----------------------------------
-- Zone rescheduled NMs
-- Zone.onInitialize overwrites mob initialize timers with a 12 to 36 hour roll.
-- Restore after the zone's super call. Without a saved deadline, keep its roll.
-----------------------------------
local zoneRescheduledNMs =
{
    -- { zone script folder, zone enum, id key, mob file name }
    { 'Mount_Zhayolm', xi.zone.MOUNT_ZHAYOLM, 'CERBERUS', 'Cerberus' },
    { 'Caedarva_Mire', xi.zone.CAEDARVA_MIRE, 'KHIMAIRA', 'Khimaira' },
}

for _, entry in ipairs(zoneRescheduledNMs) do
    local zoneName = entry[1]
    local zoneId   = entry[2]
    local idKey    = entry[3]
    local mobName  = entry[4]

    m:addOverride(string.format('xi.zones.%s.Zone.onInitialize', zoneName), function(zone)
        super(zone)

        -- Replace the zone's roll with the saved remainder, floored at 60 seconds.
        local deadline = GetServerVariable(varPrefix .. mobName)
        if deadline > 0 then
            GetMobByID(zones[zoneId].mob[idKey]):setRespawnTime(math.max(deadline - GetSystemTime(), 60))
        end
    end)
end

-----------------------------------
-- Shared pairs
-- Save the selected NM and its deadline. DisallowRespawn does not cancel pending
-- timers, so clear both before super rolls. Restore after the zone's boot reroll.
-----------------------------------
local sharedPairs =
{
    -- { zone script folder, zone enum, { mob file name, id key }, { mob file name, id key } }
    { 'Maze_of_Shakhrami',  xi.zone.MAZE_OF_SHAKHRAMI,  { 'Argus', 'ARGUS' }, { 'Leech_King', 'LEECH_KING' } },
    { 'Phomiuna_Aqueducts', xi.zone.PHOMIUNA_AQUEDUCTS, { 'Eba', 'EBA' },     { 'Mahisha', 'MAHISHA' } },
}

for _, pair in ipairs(sharedPairs) do
    local zoneName = pair[1]
    local zoneId   = pair[2]
    local nameA    = pair[3][1]
    local keyA     = pair[3][2]
    local nameB    = pair[4][1]
    local keyB     = pair[4][2]
    local idA      = zones[zoneId].mob[keyA]
    local idB      = zones[zoneId].mob[keyB]
    local pairVar  = varPrefix .. nameA .. '_' .. nameB
    local pickVar  = pairVar .. '_Next'

    for _, mobName in ipairs({ nameA, nameB }) do
        m:addOverride(string.format('xi.zones.%s.mobs.%s.onMobDespawn', zoneName, mobName), function(mob)
            -- Leave only the timer super chooses, including when the dead NM loses the roll.
            GetMobByID(idA):setRespawnTime(0)
            GetMobByID(idB):setRespawnTime(0)

            super(mob)

            for _, id in ipairs({ idA, idB }) do
                local remaining = GetMobByID(id):getRespawnTime()
                if remaining > 0 then
                    SetServerVariable(pairVar, GetSystemTime() + remaining)
                    SetServerVariable(pickVar, id)
                end
            end
        end)

        m:addOverride(string.format('xi.zones.%s.mobs.%s.onMobInitialize', zoneName, mobName), function(mob)
            super(mob)

            -- The other twin's spawn must not clear the selected NM's deadline.
            mob:addListener('SPAWN', 'PXI_TNM_SPAWN', function(mobArg)
                if mobArg:getID() == GetServerVariable(pickVar) then
                    SetServerVariable(pairVar, 0)
                end
            end)
        end)
    end

    m:addOverride(string.format('xi.zones.%s.Zone.onInitialize', zoneName), function(zone)
        super(zone)

        -- Keep the zone's roll when nothing was saved.
        local deadline = GetServerVariable(pairVar)
        if deadline == 0 then
            return
        end

        -- Discard invalid selections so the next despawn can save a fresh pair.
        local nextId = GetServerVariable(pickVar)
        if nextId ~= idA and nextId ~= idB then
            SetServerVariable(pairVar, 0)
            SetServerVariable(pickVar, 0)
            return
        end

        -- Cancel the zone's other selection before restoring the saved one.
        GetMobByID(nextId == idA and idB or idA):setRespawnTime(0)
        xi.mob.updateNMSpawnPoint(nextId)
        GetMobByID(nextId):setRespawnTime(math.max(deadline - GetSystemTime(), 60))
    end)
end

-----------------------------------
-- Beastmen kings
-- NQ despawns increment [PH] when rescheduling the NQ, but leave it unchanged for HQ.
-- Exclude Orcish Overlord and Diamond Quadav quest copies, which keep their own windows.
-----------------------------------
local kings =
{
    -- { zone script folder, zone enum, NQ id key, NQ file name, HQ file name, HQ id offset, [PH] counter }
    { 'Castle_Oztroja',  xi.zone.CASTLE_OZTROJA,  'YAGUDO_AVATAR',   'Yagudo_Avatar',   'Tzee_Xicu_the_Manifest', 3, '[PH]Tzee_Xicu_the_Manifest' },
    { 'Monastic_Cavern', xi.zone.MONASTIC_CAVERN, 'ORCISH_OVERLORD', 'Orcish_Overlord', 'Overlord_Bakgodek',      1, '[PH]Overlord_Bakgodek' },
    { 'Qulun_Dome',      xi.zone.QULUN_DOME,      'DIAMOND_QUADAV',  'Diamond_Quadav',  'ZaDha_Adamantking',      1, '[PH]Za_Dha_Adamantking' },
}

for _, king in ipairs(kings) do
    local zoneName   = king[1]
    local zoneId     = king[2]
    local nqKey      = king[3]
    local nqName     = king[4]
    local hqName     = king[5]
    local hqOffset   = king[6]
    local counterVar = king[7]
    local nqId       = zones[zoneId].mob[nqKey]
    local pairVar    = varPrefix .. nqName
    local pickVar    = pairVar .. '_Next'

    m:addOverride(string.format('xi.zones.%s.mobs.%s.onMobDespawn', zoneName, nqName), function(mob)
        -- Read before super changes the counter so its selection can be identified.
        local before = GetServerVariable(counterVar)

        super(mob)

        if mob:getID() ~= nqId then
            return
        end

        -- An unchanged counter means super scheduled the king.
        local pickId    = GetServerVariable(counterVar) == before and (nqId + hqOffset) or nqId
        local remaining = GetMobByID(pickId):getRespawnTime()
        if remaining > 0 then
            SetServerVariable(pairVar, GetSystemTime() + remaining)
            SetServerVariable(pickVar, pickId)
        end
    end)

    m:addOverride(string.format('xi.zones.%s.mobs.%s.onMobDespawn', zoneName, hqName), function(mob)
        super(mob)

        -- The king's despawn resets the counter and schedules the NQ.
        local remaining = GetMobByID(nqId):getRespawnTime()
        if remaining > 0 then
            SetServerVariable(pairVar, GetSystemTime() + remaining)
            SetServerVariable(pickVar, nqId)
        end
    end)

    for _, mobName in ipairs({ nqName, hqName }) do
        m:addOverride(string.format('xi.zones.%s.mobs.%s.onMobInitialize', zoneName, mobName), function(mob)
            super(mob)

            local mobId = mob:getID()
            local hqId  = nqId + hqOffset

            if mobId ~= nqId and mobId ~= hqId then
                return
            end

            -- Only the selected NM's spawn clears the shared deadline.
            mob:addListener('SPAWN', 'PXI_TNM_SPAWN', function(mobArg)
                if mobArg:getID() == GetServerVariable(pickVar) then
                    SetServerVariable(pairVar, 0)
                end
            end)

            local deadline = GetServerVariable(pairVar)
            if deadline == 0 then
                return
            end

            -- An invalid selection would unregister both NMs below. Discard it first.
            local nextId = GetServerVariable(pickVar)
            if nextId ~= nqId and nextId ~= hqId then
                SetServerVariable(pairVar, 0)
                SetServerVariable(pickVar, 0)
                return
            end

            -- Restore the selected NM and cancel the other's timer, including its initialize roll.
            if mobId == nextId then
                xi.mob.updateNMSpawnPoint(mob)
                mob:setRespawnTime(math.max(deadline - GetSystemTime(), 60))
            else
                mob:setRespawnTime(0)
            end
        end)
    end
end

-----------------------------------
-- Local var windows
-- Persist deadlines lost on restart. Restore after super. Zone handlers treat
-- expired deadlines as due, so no 60 second floor is needed. Dosetsu Tree's
-- window comes from the era module, the others from base scripts.
-----------------------------------
local localVarNMs =
{
    -- { zone script folder, mob file name, local var }
    { 'Caedarva_Mire',    'Zikko',             'cooldown' },
    { 'Manaclipper',      'Zoredonite',        'respawn' },
    { 'Phanauet_Channel', 'Stubborn_Dredvodd', 'cooldown' },
    { 'Phanauet_Channel', 'Vodyanoi',          'respawn' },
    { 'Qufim_Island',     'Dosetsu_Tree',      'respawn' },
    { 'Sacrarium',        'Elel',              'cooldown' },
}

for _, entry in ipairs(localVarNMs) do
    local zoneName = entry[1]
    local mobName  = entry[2]
    local localVar = entry[3]
    local varName  = varPrefix .. mobName

    m:addOverride(string.format('xi.zones.%s.mobs.%s.onMobInitialize', zoneName, mobName), function(mob)
        super(mob)

        mob:addListener('DESPAWN', 'PXI_TNM_DESPAWN', function(mobArg)
            SetServerVariable(varName, mobArg:getLocalVar(localVar))
        end)

        -- Dredvodd and Vodyanoi set their next window in onMobSpawn, before this listener.
        -- The other four have empty or expired values here.
        mob:addListener('SPAWN', 'PXI_TNM_SPAWN', function(mobArg)
            SetServerVariable(varName, mobArg:getLocalVar(localVar))
        end)

        local deadline = GetServerVariable(varName)
        if deadline > 0 then
            mob:setLocalVar(localVar, deadline)
        end
    end)
end

-----------------------------------
-- King Vinegarroon (Western Altepa Desert)
-- Boot re-allows his restored timer, but the initial weather handler skips nonzero
-- timers. Disallow him until a later weather change permits the spawn.
-----------------------------------
m:addOverride('xi.zones.Western_Altepa_Desert.Zone.onInitialize', function(zone)
    super(zone)

    DisallowRespawn(zones[xi.zone.WESTERN_ALTEPA_DESERT].mob.KING_VINEGARROON, true)
end)

-----------------------------------
-- Odqan (Misareaux Coast)
-- Save the selected twin's ID and 2 to 5 hour deadline across restarts.
-- Fog selects the allowed twin without gating timed spawns. He despawns on the next non-fog change.
-----------------------------------
local odqanIds         = zones[xi.zone.MISAREAUX_COAST].mob.ODQAN
local odqanVar         = varPrefix .. 'Odqan'
local odqanPickVar     = odqanVar .. '_Next'
local odqanTwinHoldVar = varPrefix .. 'twinHold'

m:addOverride('xi.zones.Misareaux_Coast.mobs.Odqan.onMobDespawn', function(mob)
    super(mob)

    -- Save the canSpawn selection. A spawned twin gets no pending timer and has nothing to save.
    for _, id in ipairs(odqanIds) do
        local odqan = GetMobByID(id)
        if odqan then
            local isPick    = odqan:getLocalVar('canSpawn') == 1
            local remaining = odqan:getRespawnTime()

            if isPick and remaining > 0 then
                SetServerVariable(odqanVar, GetSystemTime() + remaining)
                SetServerVariable(odqanPickVar, id)
            end

            -- A real roll replaces the winner's week hold. Cancel it for the loser.
            if odqan:getLocalVar(odqanTwinHoldVar) == 1 then
                odqan:setLocalVar(odqanTwinHoldVar, 0)

                if not isPick then
                    odqan:setRespawnTime(0)
                end
            end
        end
    end
end)

m:addOverride('xi.zones.Misareaux_Coast.mobs.Odqan.onMobInitialize', function(mob)
    super(mob)

    local mobId = mob:getID()

    -- Capture the normal window before the hold replaces it. Restore it on spawn.
    local baseWindow = GetMobRespawnTime(mobId)

    mob:addListener('SPAWN', 'PXI_TNM_SPAWN', function(mobArg)
        -- Only the selected spawn clears the deadline. The other twin can still
        -- spawn from an old timer that the base roll left pending.
        if mobArg:getID() == GetServerVariable(odqanPickVar) then
            SetServerVariable(odqanVar, 0)
        end

        if baseWindow > 0 then
            mobArg:setRespawnTime(baseWindow)
        end
    end)

    local deadline = GetServerVariable(odqanVar)
    local nextId   = GetServerVariable(odqanPickVar)

    -- Missing or invalid saves retain base behavior: both twins boot spawn.
    if
        deadline == 0 or
        (nextId ~= odqanIds[1] and nextId ~= odqanIds[2])
    then
        return
    end

    local remaining = deadline - GetSystemTime()

    -- Boot resets respawn flags, so the other twin needs a pending timer to stay down.
    -- Hold it for one week. The next real despawn roll removes that hold.
    if mobId == nextId then
        mob:setLocalVar('canSpawn', 1)

        if remaining > 0 then
            mob:setRespawnTime(remaining)
        end
    else
        mob:setLocalVar('canSpawn', 0)
        mob:setLocalVar(odqanTwinHoldVar, 1)
        mob:setRespawnTime(604800)
    end
end)

-----------------------------------
-- Carmine Dobsonfly (Riverne - Site A01)
-- All ten share a 21 to 24 hour window after a full clear and restore together.
-- Partial clears have no deadline, so dead flies boot spawn as in base LSB.
-----------------------------------
local dobsonflyVar = varPrefix .. 'Carmine_Dobsonfly'

m:addOverride('xi.zones.Riverne-Site_A01.mobs.Carmine_Dobsonfly.onMobDespawn', function(mob)
    super(mob)

    -- No group window exists until all ten are down.
    local offset = zones[xi.zone.RIVERNE_SITE_A01].mob.CARMINE_DOBSONFLY_OFFSET
    for id = offset, offset + 9 do
        if GetMobByID(id):isAlive() then
            return
        end
    end

    local remaining = mob:getRespawnTime()
    if remaining > 0 then
        SetServerVariable(dobsonflyVar, GetSystemTime() + remaining)
    end
end)

m:addOverride('xi.zones.Riverne-Site_A01.mobs.Carmine_Dobsonfly.onMobInitialize', function(mob)
    super(mob)

    -- Capture before restoring the remainder. Reset the normal window on spawn
    -- so an early kill stays down until all ten die.
    local baseWindow = GetMobRespawnTime(mob:getID())

    mob:addListener('SPAWN', 'PXI_TNM_SPAWN', function(mobArg)
        SetServerVariable(dobsonflyVar, 0)

        if baseWindow > 0 then
            mobArg:setRespawnTime(baseWindow)
        end
    end)

    local deadline = GetServerVariable(dobsonflyVar)
    if deadline > 0 then
        mob:setRespawnTime(math.max(deadline - GetSystemTime(), 60))
    end
end)

-----------------------------------
-- Lumber Jack (Batallia Downs)
-- Willow's despawn spawns him at her position. His despawn replaces her saved deadline
-- with 21 to 24 hours if killed, or 30 minutes if idle. Save his alive state to
-- restore him after a restart during his ten minute lifetime.
-----------------------------------
local lumberJackUpVar = varPrefix .. 'Lumber_Jack_Up'
local willowVar       = varPrefix .. 'Weeping_Willow'

m:addOverride('xi.zones.Batallia_Downs.mobs.Lumber_Jack.onMobInitialize', function(mob)
    super(mob)

    if GetServerVariable(lumberJackUpVar) == 0 then
        return
    end

    -- A one second timer restores him on the next boot spawn wave. Allow his idle
    -- lifetime plus two 30 second waves before Willow is due, or his idle despawn
    -- could delay her by another 30 minutes.
    if GetServerVariable(willowVar) - GetSystemTime() > mob:getMobMod(xi.mobMod.IDLE_DESPAWN) + 60 then
        mob:setRespawnTime(1)
    else
        SetServerVariable(lumberJackUpVar, 0)
    end
end)

m:addOverride('xi.zones.Batallia_Downs.mobs.Lumber_Jack.onMobDeath', function(mob, player, optParams)
    super(mob, player, optParams)

    -- Clear on death so a restart before the delayed despawn cannot duplicate drops.
    SetServerVariable(lumberJackUpVar, 0)
end)

m:addOverride('xi.zones.Batallia_Downs.mobs.Lumber_Jack.onMobSpawn', function(mob)
    super(mob)

    SetServerVariable(lumberJackUpVar, 1)

    -- Clear the persistent one second timer before it can respawn him during despawn.
    -- Normal spawns come from Willow.
    mob:setRespawnTime(0)
end)

m:addOverride('xi.zones.Batallia_Downs.mobs.Lumber_Jack.onMobDespawn', function(mob)
    super(mob)

    -- Replace Willow's stale deadline. Her entity is six IDs below Lumber Jack.
    local remaining = GetMobByID(mob:getID() - 6):getRespawnTime()
    if remaining > 0 then
        SetServerVariable(willowVar, GetSystemTime() + remaining)
    end

    SetServerVariable(lumberJackUpVar, 0)
end)
