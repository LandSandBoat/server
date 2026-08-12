-----------------------------------
-- Claim Shield
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('claim_shield')

local claimshieldTime = 5000 -- Milliseconds.

-- Entries may be a mob name or { name = 'Mob_Name', time = milliseconds }.
local shieldedEntities =
{
    ['Attohwa_Chasm'] =
    {
        'Citipati',
        'Tiamat',
        'Xolotl',
    },

    ['Batallia_Downs'] =
    {
        'Lumber_Jack',
    },

    ['Beadeaux'] =
    {
        'GaBhu_Unvanquished',
    },

    ['Beaucedine_Glacier'] =
    {
        'Nue',
    },

    ['Bibiki_Bay'] =
    {
        'Intulo',
    },

    ['Bostaunieux_Oubliette'] =
    {
        'Bloodsucker_NM',
        'Drexerion_the_Condemned',
        'Phanduron_the_Condemned',
        'Sewer_Syrup',
    },

    ['Caedarva_Mire'] =
    {
        'Khimaira',
    },

    ['Cape_Teriggan'] =
    {
        'Kreutzet',
    },

    ['Castle_Oztroja'] =
    {
        'Mee_Deggi_the_Punisher',
        'Quu_Domi_the_Gallant',
        'Tzee_Xicu_the_Manifest',
    },

    ['Castle_Zvahl_Baileys'] =
    {
        'Duke_Haborym',
        'Grand_Duke_Batym',
        'Marquis_Allocen',
        'Marquis_Amon',
    },

    ['Crawlers_Nest'] =
    {
        'Demonic_Tiphia',
    },

    ['Den_of_Rancor'] =
    {
        'Friar_Rush',
        'Tonberry_Decapitator',
        'Tonberry_Tracker',
    },

    ['East_Sarutabaruta'] =
    {
        'Spiny_Spipi',
    },

    ['Eastern_Altepa_Desert'] =
    {
        'Centurio_XII-I',
    },

    ['FeiYin'] =
    {
        'Capricious_Cassie',
        'Eastern_Shadow',
        'Northern_Shadow',
        'Southern_Shadow',
        'Western_Shadow',
    },

    ['Garlaige_Citadel'] =
    {
        'Serket',
    },

    ['Giddeus'] =
    {
        'Hoo_Mjuu_the_Torrent',
    },

    ['Gustav_Tunnel'] =
    {
        'Amikiri',
        'Bune',
    },

    ['Jugner_Forest'] =
    {
        'King_Arthro',
        'Panzer_Percival',
    },

    ['King_Ranperres_Tomb'] =
    {
        'Vrtra',
        'Cemetery_Cherry',
        'Spook',
    },

    ['Konschtat_Highlands'] =
    {
        'Steelfleece_Baldarich',
        'Stray_Mary',
    },

    ['Korroloka_Tunnel'] =
    {
        'Cargo_Crab_Colin',
    },

    ['Kuftal_Tunnel'] =
    {
        'Amemet',
        'Yowie',
    },

    ['La_Theine_Plateau'] =
    {
        'Bloodtear_Baldurf',
    },

    ['Labyrinth_of_Onzozo'] =
    {
        'Lord_of_Onzozo',
        'Mysticmaker_Profblix',
        'Ose',
    },

    ['Lufaise_Meadows'] =
    {
        'Padfoot',
        'Megalobugard',
    },

    ['Maze_of_Shakhrami'] =
    {
        'Argus',
        'Leech_King',
    },

    ['Misareaux_Coast'] =
    {
        'Upyri',
        'Odqan',
    },

    ['Monastic_Cavern'] =
    {
        'Overlord_Bakgodek',
    },

    ['Mount_Zhayolm'] =
    {
        'Cerberus',
    },

    ['Ordelles_Caves'] =
    {
        'Morbolger',
    },

    ['Promyvion-Dem'] =
    {
        'Satiator',
    },

    ['Quicksand_Caves'] =
    {
        'Centurio_X-I',
        'Sabotender_Bailarina',
    },

    ['Qulun_Dome'] =
    {
        'ZaDha_Adamantking',
    },

    ['Riverne-Site_A01'] =
    {
        'Carmine_Dobsonfly',
    },

    ['Riverne-Site_B01'] =
    {
        'Boroka',
    },

    ['Rolanberry_Fields'] =
    {
        -- 'Eldritch_Edge',
        'Simurgh',
    },

    ['Rolanberry_Fields_[S]'] =
    {
        -- 'Lamina',
    },

    ['RoMaeve'] =
    {
        'Shikigami_Weapon',
    },

    ['Sacrarium'] =
    {
        'Elel',
    },

    ['Sauromugue_Champaign'] =
    {
        -- 'Blighting_Brand',
        'Roc',
    },

    ['Sauromugue_Champaign_[S]'] =
    {
        -- 'Hyakinthos',
    },

    ['Sea_Serpent_Grotto'] =
    {
        'Charybdis',
        'Fyuu_the_Seabellow',
        'Novv_the_Whitehearted',
        'Sea_Hog',
    },

    ['South_Gustaberg'] =
    {
        'Leaping_Lizzy',
        'Carnero',
    },

    ['Temple_of_Uggalepih'] =
    {
        'Sozu_Sarberry',
        'Sozu_Terberry',
    },

    ['The_Boyahda_Tree'] =
    {
        'Voluptuous_Vivian',
        'Ancient_Goobbue',
    },

    ['The_Sanctuary_of_ZiTah'] =
    {
        'Noble_Mold',
    },

    ['The_Shrine_of_RuAvitau'] =
    {
        'Faust',
        'Mother_Globe',
    },

    ['Uleguerand_Range'] =
    {
        'Jormungand',
        'Bonnacon',
    },

    ['Valkurm_Dunes'] =
    {
        'Valkurm_Emperor',
    },

    ['VeLugannon_Palace'] =
    {
        'Zipacna',
    },

    ['Wajaom_Woodlands'] =
    {
        'Hydra',
        'Jaded_Jody',
        'Zoraal_Jas_Pkuucha',
    },

    ['Western_Altepa_Desert'] =
    {
        'King_Vinegarroon',
    },

    ['Xarcabard'] =
    {
        'Biast',
    },

    ['Yhoator_Jungle'] =
    {
        'Bright-handed_Kunberry',
    },

    ['Yuhtunga_Jungle'] =
    {
        'Rose_Garden',
        'Voluptuous_Vilma',
    },
}

-- Adds claim shield and sets the mob up to collect entries.
local startClaimShield = function(mob, shieldTime)
    mob:setMobMod(xi.mobMod.CLAIM_TYPE, xi.claimType.UNCLAIMABLE)
    mob:setUnkillable(true)
    mob:setCallForHelpBlocked(true)
    mob:stun(shieldTime)
end

-- Collects all unique entries from the mobs enmity list and returns them as a table.
local collectEntries = function(mob)
    local entries     = {}
    local seenPlayers = {}

    for _, enmityEntry in pairs(mob:getEnmityList()) do
        local entity = enmityEntry.entity
        local player = entity:isPC() and entity or entity:getMaster()

        if player and player:isPC() then
            local playerId = player:getID()
            if not seenPlayers[playerId] then
                seenPlayers[playerId] = true
                entries[#entries + 1] = player
            end
        end
    end

    return entries
end

-- Removes claim shield.
local endClaimShield = function(mob)
    mob:setUnkillable(false)
    mob:setCallForHelpBlocked(false)
    mob:setHP(mob:getMaxHP())

    local mobId = mob:getID()
    for _, effect in ipairs(mob:getStatusEffects()) do
        if effect:getOriginID() ~= mobId then
            mob:delStatusEffectSilent(effect:getEffectType())
        end
    end
end

-- Selects a winner, awards claim, notifies entrants, and clears enmity for losing entrants.
local resolveLottery = function(mob, entries)
    mob:setMobMod(xi.mobMod.CLAIM_TYPE, xi.claimType.EXCLUSIVE)

    for _, enmityEntry in pairs(mob:getEnmityList()) do
        local entity = enmityEntry.entity
        if entity then
            if not entity:isPC() then
                entity:disengage()
            end

            mob:resetEnmity(entity)
        end
    end

    mob:resetAI()
    mob:disengage()

    local entrantCount = #entries
    local claimWinner  = utils.randomEntry(entries)
    if not claimWinner then
        return
    end

    local alliance       = claimWinner:getAlliance()
    local winningMembers = {}
    local winnerPrefix   = #alliance == 1 and 'You have' or 'Your group has'
    local winnerMessage  = string.format('%s won the lottery for %s! (out of %i players)', winnerPrefix, mob:getPacketName(), entrantCount)

    for _, member in pairs(alliance) do
        winningMembers[member:getID()] = true
    end

    mob:updateClaim(claimWinner)
    mob:addEnmity(claimWinner, 1, 1)

    for _, member in pairs(alliance) do
        member:printToPlayer(winnerMessage, xi.msg.channel.SYSTEM_3, '')
    end

    for _, entrant in ipairs(entries) do
        if not winningMembers[entrant:getID()] then
            local loserAlliance = entrant:getAlliance()
            local loserPrefix   = #loserAlliance == 1 and 'You were' or 'Your group was'
            local loserMessage  = string.format('%s not successful in the lottery for %s. (out of %i players)', loserPrefix, mob:getPacketName(), entrantCount)
            entrant:printToPlayer(loserMessage, xi.msg.channel.SYSTEM_3, '')
        end
    end
end

-- Adds Claim Shield listener on spawn.
local addClaimshield = function(mob, shieldTime)
    mob:addListener('SPAWN', string.format('%s_CS_SPAWN', mob:getPacketName()), function(mobArg)
        print(string.format('Applying Claimshield to %s for %ims', mobArg:getPacketName(), shieldTime))
        mob:setPriorityRender(true) -- Make sure the mob is visible to all players
        startClaimShield(mobArg, shieldTime)

        mobArg:timer(shieldTime, function(mobArgTwo)
            local entries = collectEntries(mobArgTwo)

            endClaimShield(mobArgTwo)
            resolveLottery(mobArgTwo, entries)
        end)
    end)
end

for zoneName, entities in pairs(shieldedEntities) do
    for _, entity in ipairs(entities) do
        local mobName    = type(entity) == 'table' and entity.name or entity
        local shieldTime = type(entity) == 'table' and entity.time or claimshieldTime

        m:addOverride(string.format('xi.zones.%s.mobs.%s.onMobInitialize', zoneName, mobName), function(mob)
            addClaimshield(mob, shieldTime)
            super(mob)
        end)
    end
end
