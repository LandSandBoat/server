/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#include "common/xirand.h"
#include "map/utils/fishingutils.h"

#include <catch2/catch_test_macros.hpp>

#include <cmath>
#include <cstdlib>

TEST_CASE("Fishing legendary attack bonuses also increase wrong-arrow healing", "[fishing]")
{
    auto rod         = rod_t{};
    rod.fishAttack   = 100;
    rod.lgdBonusAtk  = 50;
    rod.fishRecovery = 50;

    CHECK(fishingutils::CalculateAttack(fishingutils::Legendary::No, 20, &rod) == 400);
    CHECK(fishingutils::CalculateAttack(fishingutils::Legendary::Yes, 20, &rod) == 600);
    CHECK(fishingutils::CalculateHeal(fishingutils::Legendary::No, 20, &rod) == 100);
    CHECK(fishingutils::CalculateHeal(fishingutils::Legendary::Yes, 20, &rod) == 150);
}

TEST_CASE("Fishing area segments intersect at crossings, endpoints and overlaps", "[fishing]")
{
    CHECK(fishingutils::doIntersect({ 0, 0, 0 }, { 10, 0, 10 }, { 0, 0, 10 }, { 10, 0, 0 }));
    CHECK(fishingutils::doIntersect({ 0, 0, 0 }, { 10, 0, 0 }, { 10, 0, 0 }, { 20, 0, 0 }));
    CHECK(fishingutils::doIntersect({ 0, 0, 0 }, { 10, 0, 0 }, { 5, 0, 0 }, { 15, 0, 0 }));
    CHECK_FALSE(fishingutils::doIntersect({ 0, 0, 0 }, { 10, 0, 0 }, { 11, 0, 0 }, { 20, 0, 0 }));
    CHECK_FALSE(fishingutils::doIntersect({ 0, 0, 0 }, { 10, 0, 0 }, { 0, 0, 1 }, { 10, 0, 1 }));
}

TEST_CASE("Fishing polygon boundaries include edges and enforce height", "[fishing]")
{
    areavector_t polygon[] = { { 0, 0, 0 }, { 10, 0, 0 }, { 10, 0, 10 }, { 0, 0, 10 } };

    CHECK(fishingutils::isInsidePoly(polygon, 4, { 5, 0, 5 }, 0, 4));
    CHECK(fishingutils::isInsidePoly(polygon, 4, { 0, 0, 5 }, 0, 4));
    CHECK(fishingutils::isInsidePoly(polygon, 4, { 5, 2, 5 }, 0, 4));
    CHECK(fishingutils::isInsidePoly(polygon, 4, { 5, -2, 5 }, 0, 4));
    CHECK_FALSE(fishingutils::isInsidePoly(polygon, 4, { 11, 0, 5 }, 0, 4));
    CHECK_FALSE(fishingutils::isInsidePoly(polygon, 4, { 5, 3, 5 }, 0, 4));
    CHECK_FALSE(fishingutils::isInsidePoly(polygon, 4, { 5, -3, 5 }, 0, 4));
    CHECK_FALSE(fishingutils::isInsidePoly(polygon, 2, { 5, 0, 5 }, 0, 4));
}

TEST_CASE("Fishing cylinders include the radius and reject points beyond it", "[fishing]")
{
    const auto center = areavector_t{ 10, 20, 30 };

    CHECK(fishingutils::isInsideCylinder(center, { 10, 20, 30 }, 5, 4));
    CHECK(fishingutils::isInsideCylinder(center, { 13, 20, 34 }, 5, 4));
    CHECK(fishingutils::isInsideCylinder(center, { 7, 20, 26 }, 5, 4));
    CHECK(fishingutils::isInsideCylinder(center, { 10, 22, 30 }, 5, 4));
    CHECK(fishingutils::isInsideCylinder(center, { 10, 18, 30 }, 5, 4));
    CHECK_FALSE(fishingutils::isInsideCylinder(center, { 14, 20, 34 }, 5, 4));
    CHECK_FALSE(fishingutils::isInsideCylinder(center, { 16, 20, 30 }, 5, 4));
    CHECK_FALSE(fishingutils::isInsideCylinder(center, { 10, 20, 36 }, 5, 4));
    CHECK_FALSE(fishingutils::isInsideCylinder(center, { 10, 23, 30 }, 5, 4));
    CHECK_FALSE(fishingutils::isInsideCylinder(center, { 10, 17, 30 }, 5, 4));
}

TEST_CASE("Fishing small-fish losses depend on fish level, not angler skill or rank", "[fishing]")
{
    auto rod     = rod_t{};
    rod.rodID    = COMPOSITE;
    rod.sizeType = FISHINGSIZETYPE_LARGE;
    rod.minRank  = 1;

    for (const auto skill : { 20, 100 })
    {
        for (const auto rank : { 0, 10 })
        {
            CAPTURE(skill, rank);
            const auto result = fishingutils::CalculateLoseChance(FISHINGCATCHTYPE_SMALLFISH, skill, 20, FISHINGSIZETYPE_SMALL, false, rank, &rod);
            CHECK(result.failReason == FISHINGFAILTYPE_LOST_TOOSMALL);
            CHECK(result.chance == 36);
        }
    }
}

TEST_CASE("Fishing small-fish loss chance stops at ninety percent", "[fishing]")
{
    auto rod     = rod_t{};
    rod.sizeType = FISHINGSIZETYPE_LARGE;

    for (const auto level : { 50, 100 })
    {
        CAPTURE(level);
        const auto result = fishingutils::CalculateLoseChance(FISHINGCATCHTYPE_SMALLFISH, 100, level, FISHINGSIZETYPE_SMALL, false, 0, &rod);
        CHECK(result.failReason == FISHINGFAILTYPE_LOST_TOOSMALL);
        CHECK(result.chance == 90);
    }
}

TEST_CASE("Fishing legendary rods bypass size losses", "[fishing]")
{
    auto rod      = rod_t{};
    rod.legendary = true;
    rod.sizeType  = FISHINGSIZETYPE_LARGE;

    const auto result = fishingutils::CalculateLoseChance(FISHINGCATCHTYPE_SMALLFISH, 100, 50, FISHINGSIZETYPE_SMALL, false, 0, &rod);
    CHECK(result.failReason == FISHINGFAILTYPE_NONE);
    CHECK(result.chance == 0);
}

TEST_CASE("Fishing skill losses start beyond seven levels and become certain at fifty", "[fishing]")
{
    auto rod = rod_t{};

    struct SkillCase
    {
        uint8 maxSkill;
        uint8 chance;
        uint8 reason;
    };

    const SkillCase cases[] = {
        { 27, 0, FISHINGFAILTYPE_NONE },
        { 28, 0, FISHINGFAILTYPE_NONE },
        { 29, 1, FISHINGFAILTYPE_LOST_LOWSKILL },
        { 69, 33, FISHINGFAILTYPE_LOST_LOWSKILL },
        { 70, 100, FISHINGFAILTYPE_LOST_LOWSKILL },
        { 71, 100, FISHINGFAILTYPE_LOST_LOWSKILL },
    };

    for (const auto& entry : cases)
    {
        CAPTURE(entry.maxSkill);
        const auto result = fishingutils::CalculateLoseChance(FISHINGCATCHTYPE_SMALLFISH, 20, entry.maxSkill, FISHINGSIZETYPE_SMALL, false, 0, &rod);
        CHECK(result.failReason == entry.reason);
        CHECK(result.chance == entry.chance);
    }
}

TEST_CASE("Fishing guaranteed skill loss takes precedence over rod size loss", "[fishing]")
{
    auto rod     = rod_t{};
    rod.rodID    = SINGLE_HOOK;
    rod.sizeType = FISHINGSIZETYPE_LARGE;

    const auto result = fishingutils::CalculateLoseChance(FISHINGCATCHTYPE_SMALLFISH, 0, 50, FISHINGSIZETYPE_SMALL, false, 0, &rod);
    CHECK(result.failReason == FISHINGFAILTYPE_LOST_LOWSKILL);
    CHECK(result.chance == 100);
}

TEST_CASE("Fishing items and monsters do not incur low-skill losses", "[fishing]")
{
    auto rod = rod_t{};

    for (const auto type : { FISHINGCATCHTYPE_ITEM, FISHINGCATCHTYPE_MOB })
    {
        CAPTURE(type);
        const auto result = fishingutils::CalculateLoseChance(type, 0, 100, FISHINGSIZETYPE_SMALL, false, 0, &rod);
        CHECK(result.failReason == FISHINGFAILTYPE_NONE);
        CHECK(result.chance == 0);
    }
}

TEST_CASE("Fishing oversized catches have a fifty percent size-loss ceiling", "[fishing]")
{
    auto rod    = rod_t{};
    rod.maxRank = 10;

    const auto result = fishingutils::CalculateLoseChance(FISHINGCATCHTYPE_BIGFISH, 20, 40, FISHINGSIZETYPE_LARGE, false, 11, &rod);
    CHECK(result.failReason == FISHINGFAILTYPE_LOST_TOOBIG);
    CHECK(result.chance == 50);
}

TEST_CASE("Fishing oversized catches never outrank a certain low-skill loss or punish a master angler", "[fishing]")
{
    auto rod    = rod_t{};
    rod.maxRank = 10;

    struct SizeCase
    {
        uint8 fishingSkill;
        uint8 maxSkill;
        uint8 ranking;
        uint8 reason;
        uint8 chance;
    };

    // Row 1 checks the 50-level rule beats the size loss, row 2 checks the size chance can't go below zero
    const SizeCase cases[] = {
        { 0, 51, 11, FISHINGFAILTYPE_LOST_LOWSKILL, 100 },
        { 100, 18, 16, FISHINGFAILTYPE_NONE, 0 },
    };

    for (const auto& [fishingSkill, maxSkill, ranking, reason, chance] : cases)
    {
        CAPTURE(fishingSkill, maxSkill, ranking);
        const auto result = fishingutils::CalculateLoseChance(FISHINGCATCHTYPE_BIGFISH, fishingSkill, maxSkill, FISHINGSIZETYPE_LARGE, false, ranking, &rod);
        CHECK(result.failReason == reason);
        CHECK(result.chance == chance);
    }
}

TEST_CASE("Fishing line snaps begin above rod durability and cap at fifty-five", "[fishing]")
{
    auto rod    = rod_t{};
    rod.maxRank = 10;

    struct SnapCase
    {
        uint8 rank;
        uint8 chance;
    };

    // Rank 24 is the first gap whose uncapped chance overflows uint8
    const SnapCase cases[] = {
        { 10, 0 },
        { 11, 19 },
        { 12, 38 },
        { 13, 55 },
        { 24, 55 },
    };

    for (const auto& [rank, chance] : cases)
    {
        CAPTURE(rank);
        const auto result = fishingutils::CalculateSnapChance(FISHINGCATCHTYPE_SMALLFISH, 0, 10, FISHINGSIZETYPE_SMALL, false, rank, &rod);
        CHECK(result.chance == chance);
        if (rank == 10)
        {
            CHECK(result.failReason == FISHINGFAILTYPE_NONE);
        }
        else
        {
            CHECK(result.failReason == FISHINGFAILTYPE_LINESNAP);
        }
    }
}

TEST_CASE("Fishing unbreakable rods cannot break on legendary oversized fish", "[fishing]")
{
    auto rod = rod_t{};

    const auto result = fishingutils::CalculateBreakChance(FISHINGCATCHTYPE_BIGFISH, 0, 100, FISHINGSIZETYPE_LARGE, true, 100, &rod);
    CHECK(result.failReason == FISHINGFAILTYPE_NONE);
    CHECK(result.chance == 0);
}

TEST_CASE("Fishing rod breaks begin above durability and cap at twenty", "[fishing]")
{
    auto rod      = rod_t{};
    rod.breakable = true;
    rod.maxRank   = 10;

    const auto safe = fishingutils::CalculateBreakChance(FISHINGCATCHTYPE_SMALLFISH, 0, 10, FISHINGSIZETYPE_SMALL, false, 10, &rod);
    CHECK(safe.failReason == FISHINGFAILTYPE_NONE);
    CHECK(safe.chance == 0);

    const auto weak = fishingutils::CalculateBreakChance(FISHINGCATCHTYPE_SMALLFISH, 0, 10, FISHINGSIZETYPE_SMALL, false, 11, &rod);
    CHECK(weak.failReason == FISHINGFAILTYPE_RODBREAK);
    CHECK(weak.chance == 10);

    const auto capped = fishingutils::CalculateBreakChance(FISHINGCATCHTYPE_SMALLFISH, 0, 10, FISHINGSIZETYPE_SMALL, false, 100, &rod);
    CHECK(capped.failReason == FISHINGFAILTYPE_RODBREAK);
    CHECK(capped.chance == 20);

    // Rank 37 is the first gap whose uncapped chance overflows uint8
    const auto wide = fishingutils::CalculateBreakChance(FISHINGCATCHTYPE_SMALLFISH, 0, 10, FISHINGSIZETYPE_SMALL, false, 37, &rod);
    CHECK(wide.failReason == FISHINGFAILTYPE_RODBREAK);
    CHECK(wide.chance == 20);
}

TEST_CASE("Fishing a Nebimonite from the Selbina ship warns without promising", "[fishing][simulation]")
{
    // Seeded so every run checks the same reels
    xirand::rng().seed(1);

    // Stats from fishing_rod.sql and fishing_fish.sql, and Nebimonite is the only fish in zone 220 that takes Ball of Crayfish Paste
    auto rod      = rod_t{};
    rod.rodID     = TARUTARU;
    rod.sizeType  = FISHINGSIZETYPE_SMALL;
    rod.minRank   = 1;
    rod.maxRank   = 9;
    rod.breakable = true;
    rod.legendary = false;

    constexpr uint8 fishLevel   = 27;
    constexpr uint8 fishRanking = 10;
    constexpr int   reels       = 100000;

    for (const auto anglerSkill : { 0, 30 })
    {
        CAPTURE(anglerSkill);

        const auto lose  = fishingutils::CalculateLoseChance(FISHINGCATCHTYPE_SMALLFISH, anglerSkill, fishLevel, FISHINGSIZETYPE_SMALL, false, fishRanking, &rod);
        const auto snap  = fishingutils::CalculateSnapChance(FISHINGCATCHTYPE_SMALLFISH, anglerSkill, fishLevel, FISHINGSIZETYPE_SMALL, false, fishRanking, &rod);
        const auto crack = fishingutils::CalculateBreakChance(FISHINGCATCHTYPE_SMALLFISH, anglerSkill, fishLevel, FISHINGSIZETYPE_SMALL, false, fishRanking, &rod);

        // Skill doesn't change the snap or break chance
        CHECK(snap.chance == 19);
        CHECK(crack.chance == 10);

        const double loseRate  = lose.chance / 100.0;
        const double snapRate  = (1.0 - loseRate) * (snap.chance / 100.0);
        const double crackRate = (1.0 - loseRate) * (1.0 - snap.chance / 100.0) * (crack.chance / 100.0);
        const double landRate  = 1.0 - loseRate - snapRate - crackRate;

        int good     = 0;
        int bad      = 0;
        int terrible = 0;
        int doubt    = 0;

        int goodLanded    = 0;
        int badSnapped    = 0;
        int terribleBroke = 0;
        int doubtLost     = 0;

        int landed     = 0;
        int snapped    = 0;
        int cracked    = 0;
        int lostSkill  = 0;
        int quietBreak = 0;

        for (int reel = 0; reel < reels; ++reel)
        {
            auto response = fishresponse_t{};

            const auto sense = fishingutils::CalculateFishSense(nullptr, &response, anglerSkill, FISHINGCATCHTYPE_SMALLFISH, FISHINGSIZETYPE_SMALL, fishLevel, fishingutils::Legendary::No, 1, 1, fishRanking, &rod);

            auto* outcome = fishingutils::ReelCheck(nullptr, &response, &rod);

            if (sense == FISHINGSENSETYPE_TERRIBLE)
            {
                ++terrible;
                if (outcome->rodbreak)
                {
                    ++terribleBroke;
                }
            }
            else if (sense == FISHINGSENSETYPE_BAD)
            {
                ++bad;
                if (outcome->linebreak)
                {
                    ++badSnapped;
                }
            }
            else if (sense == FISHINGSENSETYPE_GOOD)
            {
                ++good;
                if (outcome->caught)
                {
                    ++goodLanded;
                }
            }
            else
            {
                ++doubt;
                if (outcome->failReason == FISHINGFAILTYPE_LOST_LOWSKILL)
                {
                    ++doubtLost;
                }
            }

            // A good feeling can still lose a too-small fish, but never the line or rod
            if ((outcome->linebreak || outcome->rodbreak) && sense == FISHINGSENSETYPE_GOOD)
            {
                ++quietBreak;
            }

            if (outcome->caught)
            {
                ++landed;
            }
            else if (outcome->linebreak)
            {
                ++snapped;
            }
            else if (outcome->rodbreak)
            {
                ++cracked;
            }
            else
            {
                ++lostSkill;
            }

            destroy(outcome);
        }

        INFO("Nebimonite, Tarutaru Fishing Rod, skill " << anglerSkill << ", over " << reels << " reels"
                                                        << "\n  rolled chances    loss " << static_cast<int>(lose.chance)
                                                        << ", snap " << static_cast<int>(snap.chance)
                                                        << ", break " << static_cast<int>(crack.chance)
                                                        << "\n  good      shown " << good << ", landed " << goodLanded
                                                        << "\n  unsure    shown " << doubt << ", lost to skill " << doubtLost
                                                        << "\n  bad       shown " << bad << ", line snapped " << badSnapped
                                                        << "\n  terrible  shown " << terrible << ", rod broke " << terribleBroke
                                                        << "\n  outcomes  landed " << landed << " (expected " << static_cast<int>(landRate * reels) << ")"
                                                        << ", snapped " << snapped << " (" << static_cast<int>(snapRate * reels) << ")"
                                                        << ", broke " << cracked << " (" << static_cast<int>(crackRate * reels) << ")"
                                                        << ", lost to skill " << lostSkill << " (" << static_cast<int>(loseRate * reels) << ")");

        // Warnings come true most of the time but not always
        CHECK(badSnapped * 100 > bad * 60);
        CHECK(badSnapped * 100 < bad * 90);
        CHECK(terribleBroke * 100 > terrible * 55);
        CHECK(terribleBroke * 100 < terrible * 85);

        // Skill messages come from the loss chance, so they are wrong more often than right
        if (lose.chance > 0)
        {
            CHECK(doubtLost * 100 < doubt * 40);
        }

        CHECK(quietBreak == 0);
        CHECK(terrible > reels / 100);

        // A 1% band is many standard deviations at 100000 reels, so these can't flake
        CHECK(std::abs(landed - static_cast<int>(landRate * reels)) < reels / 100);
        CHECK(std::abs(snapped - static_cast<int>(snapRate * reels)) < reels / 100);
        CHECK(std::abs(cracked - static_cast<int>(crackRate * reels)) < reels / 100);
        CHECK(std::abs(lostSkill - static_cast<int>(loseRate * reels)) < reels / 100);
    }
}
