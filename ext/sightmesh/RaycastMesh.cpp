#include "RaycastMesh.h"

// This code snippet allows you to create an axis aligned bounding volume tree for a triangle mesh so that you can do
// high-speed raycasting.
//
// There are much better implementations of this available on the internet.  In particular I recommend that you use
// OPCODE written by Pierre Terdiman.
// @see: http://www.codercorner.com/Opcode.htm
//
// OPCODE does a whole lot more than just raycasting, and is a rather significant amount of source code.
//
// I am providing this code snippet for the use case where you *only* want to do quick and dirty optimized raycasting.
// I have not done performance testing between this version and OPCODE; so I don't know how much slower it is.  However,
// anytime you switch to using a spatial data structure for raycasting, you increase your performance by orders and orders
// of magnitude; so this implementation should work fine for simple tools and utilities.
//
// It also serves as a nice sample for people who are trying to learn the algorithm of how to implement AABB trees.
// AABB = Axis Aligned Bounding Volume trees.
//
// http://www.cgal.org/Manual/3.5/doc_html/cgal_manual/AABB_tree/Chapter_main.html
//
//
// This code snippet was written by John W. Ratcliff on August 18, 2011 and released under the MIT. license.
//
// mailto:jratcliffscarab@gmail.com
//
// The official source can be found at:  http://code.google.com/p/raycastmesh/
//
//

#include <memory>

#include <cassert>
#include <cmath>
#include <cstring>
#include <memory>
#include <vector>

#pragma warning(disable : 4100)

/**
*	A method to compute a ray-AABB intersection.
*	Original code by Andrew Woo, from "Graphics Gems", Academic Press, 1990
*	Optimized code by Pierre Terdiman, 2000 (~20-30% faster on my Celeron 500)
*	Epsilon value added by Klaus Hartmann. (discarding it saves a few cycles only)
*
*	Hence this version is faster as well as more robust than the original one.
*
*	Should work provided:
*	1) the integer representation of 0.0f is 0x00000000
*	2) the sign bit of the float is the most significant one
*
*	Report bugs: p.terdiman@codercorner.com
*
*	\param		aabb		[in] the axis-aligned bounding box
*	\param		origin		[in] ray origin
*	\param		dir			[in] ray direction
*	\param		coord		[out] impact coordinates
*	\return		true if ray intersects AABB
*/

#define RAYAABB_EPSILON 0.00001f
//! Integer representation of a floating-point value.
#define IR(x) ((unsigned int&)x)

bool intersectRayAABB(const float MinB[3], const float MaxB[3], const float origin[3], const float dir[3], float coord[3])
{
    bool  Inside = true;
    float MaxT[3];
    MaxT[0] = MaxT[1] = MaxT[2] = -1.0f;

    // Find candidate planes.
    for (unsigned int i = 0; i < 3; i++)
    {
        if (origin[i] < MinB[i])
        {
            coord[i] = MinB[i];
            Inside   = false;

            // Calculate T distances to candidate planes
            if (IR(dir[i]))
                MaxT[i] = (MinB[i] - origin[i]) / dir[i];
        }
        else if (origin[i] > MaxB[i])
        {
            coord[i] = MaxB[i];
            Inside   = false;

            // Calculate T distances to candidate planes
            if (IR(dir[i]))
                MaxT[i] = (MaxB[i] - origin[i]) / dir[i];
        }
    }

    // Ray origin inside bounding box
    if (Inside)
    {
        coord[0] = origin[0];
        coord[1] = origin[1];
        coord[2] = origin[2];
        return true;
    }

    // Get largest of the maxT's for final choice of intersection
    unsigned int WhichPlane = 0;
    if (MaxT[1] > MaxT[WhichPlane])
        WhichPlane = 1;
    if (MaxT[2] > MaxT[WhichPlane])
        WhichPlane = 2;

    // Check final candidate actually inside box
    if (IR(MaxT[WhichPlane]) & 0x80000000)
        return false;

    for (unsigned int i = 0; i < 3; i++)
    {
        if (i != WhichPlane)
        {
            coord[i] = origin[i] + MaxT[WhichPlane] * dir[i];
#ifdef RAYAABB_EPSILON
            if (coord[i] < MinB[i] - RAYAABB_EPSILON || coord[i] > MaxB[i] + RAYAABB_EPSILON)
                return false;
#else
            if (coord[i] < MinB[i] || coord[i] > MaxB[i])
                return false;
#endif
        }
    }
    return true; // ray hits box
}

bool intersectLineSegmentAABB(const float bmin[3], const float bmax[3], const float p1[3], const float dir[3], float& dist, float intersect[3])
{
    bool ret = false;

    if (dist > RAYAABB_EPSILON)
    {
        ret = intersectRayAABB(bmin, bmax, p1, dir, intersect);
        if (ret)
        {
            float dx = p1[0] - intersect[0];
            float dy = p1[1] - intersect[1];
            float dz = p1[2] - intersect[2];
            float d  = dx * dx + dy * dy + dz * dz;
            if (d < dist * dist)
            {
                dist = sqrtf(d);
            }
            else
            {
                ret = false;
            }
        }
    }
    return ret;
}

/* a = b - c */
#define vector(a, b, c)       \
    (a)[0] = (b)[0] - (c)[0]; \
    (a)[1] = (b)[1] - (c)[1]; \
    (a)[2] = (b)[2] - (c)[2];

#define innerProduct(v, q) \
    ((v)[0] * (q)[0] +     \
     (v)[1] * (q)[1] +     \
     (v)[2] * (q)[2])

#define crossProduct(a, b, c)                   \
    (a)[0] = (b)[1] * (c)[2] - (c)[1] * (b)[2]; \
    (a)[1] = (b)[2] * (c)[0] - (c)[2] * (b)[0]; \
    (a)[2] = (b)[0] * (c)[1] - (c)[0] * (b)[1];

static inline bool rayIntersectsTriangle(const float* p, const float* d, const float* v0, const float* v1, const float* v2, float& t)
{
    float e1[3], e2[3], h[3], s[3], q[3];
    float a, f, u, v;

    vector(e1, v1, v0);
    vector(e2, v2, v0);
    crossProduct(h, d, e2);
    a = innerProduct(e1, h);

    if (a > -0.00001 && a < 0.00001)
        return (false);

    f = 1 / a;
    vector(s, p, v0);
    u = f * (innerProduct(s, h));

    if (u < 0.0 || u > 1.0)
        return (false);

    crossProduct(q, s, e1);
    v = f * innerProduct(d, q);
    if (v < 0.0 || u + v > 1.0)
        return (false);
    // at this stage we can compute t to find out where
    // the intersection point is on the line
    t = f * innerProduct(e2, q);
    if (t > 0) // ray intersection
        return (true);
    else // this means that there is a line intersection
        // but not a ray intersection
        return (false);
}

static float computePlane(const float* A, const float* B, const float* C, float* n) // returns D
{
    float vx = (B[0] - C[0]);
    float vy = (B[1] - C[1]);
    float vz = (B[2] - C[2]);

    float wx = (A[0] - B[0]);
    float wy = (A[1] - B[1]);
    float wz = (A[2] - B[2]);

    float vw_x = vy * wz - vz * wy;
    float vw_y = vz * wx - vx * wz;
    float vw_z = vx * wy - vy * wx;

    float mag = sqrt((vw_x * vw_x) + (vw_y * vw_y) + (vw_z * vw_z));

    if (mag < 0.000001f)
    {
        mag = 0;
    }
    else
    {
        mag = 1.0f / mag;
    }

    float x = vw_x * mag;
    float y = vw_y * mag;
    float z = vw_z * mag;

    float D = 0.0f - ((x * A[0]) + (y * A[1]) + (z * A[2]));

    n[0] = x;
    n[1] = y;
    n[2] = z;

    return D;
}

#define TRI_EOF 0xFFFFFFFF

enum AxisAABB
{
    AABB_XAXIS,
    AABB_YAXIS,
    AABB_ZAXIS
};

enum ClipCode
{
    CC_MINX = (1 << 0),
    CC_MAXX = (1 << 1),
    CC_MINY = (1 << 2),
    CC_MAXY = (1 << 3),
    CC_MINZ = (1 << 4),
    CC_MAXZ = (1 << 5),
};

class BoundsAABB
{
public:
    void setMin(const float* v)
    {
        mMin[0] = v[0];
        mMin[1] = v[1];
        mMin[2] = v[2];
    }

    void setMax(const float* v)
    {
        mMax[0] = v[0];
        mMax[1] = v[1];
        mMax[2] = v[2];
    }

    void setMin(float x, float y, float z)
    {
        mMin[0] = x;
        mMin[1] = y;
        mMin[2] = z;
    }

    void setMax(float x, float y, float z)
    {
        mMax[0] = x;
        mMax[1] = y;
        mMax[2] = z;
    }

    void include(const float* v)
    {
        if (v[0] < mMin[0])
            mMin[0] = v[0];
        if (v[1] < mMin[1])
            mMin[1] = v[1];
        if (v[2] < mMin[2])
            mMin[2] = v[2];

        if (v[0] > mMax[0])
            mMax[0] = v[0];
        if (v[1] > mMax[1])
            mMax[1] = v[1];
        if (v[2] > mMax[2])
            mMax[2] = v[2];
    }

    void getCenter(float* center) const
    {
        center[0] = (mMin[0] + mMax[0]) * 0.5f;
        center[1] = (mMin[1] + mMax[1]) * 0.5f;
        center[2] = (mMin[2] + mMax[2]) * 0.5f;
    }

    bool intersects(const BoundsAABB& b) const
    {
        if ((mMin[0] > b.mMax[0]) || (b.mMin[0] > mMax[0]))
            return false;
        if ((mMin[1] > b.mMax[1]) || (b.mMin[1] > mMax[1]))
            return false;
        if ((mMin[2] > b.mMax[2]) || (b.mMin[2] > mMax[2]))
            return false;
        return true;
    }

    bool containsTriangle(const float* p1, const float* p2, const float* p3) const
    {
        BoundsAABB b;
        b.setMin(p1);
        b.setMax(p1);
        b.include(p2);
        b.include(p3);
        return intersects(b);
    }

    bool containsTriangleExact(const float* p1, const float* p2, const float* p3, unsigned int& orCode) const
    {
        bool ret = false;

        unsigned int andCode;
        orCode = getClipCode(p1, p2, p3, andCode);
        if (andCode == 0)
        {
            ret = true;
        }

        return ret;
    }

    inline unsigned int getClipCode(const float* p1, const float* p2, const float* p3, unsigned int& andCode) const
    {
        andCode         = 0xFFFFFFFF;
        unsigned int c1 = getClipCode(p1);
        unsigned int c2 = getClipCode(p2);
        unsigned int c3 = getClipCode(p3);
        andCode &= c1;
        andCode &= c2;
        andCode &= c3;
        return c1 | c2 | c3;
    }

    inline unsigned int getClipCode(const float* p) const
    {
        unsigned int ret = 0;

        if (p[0] < mMin[0])
        {
            ret |= CC_MINX;
        }
        else if (p[0] > mMax[0])
        {
            ret |= CC_MAXX;
        }

        if (p[1] < mMin[1])
        {
            ret |= CC_MINY;
        }
        else if (p[1] > mMax[1])
        {
            ret |= CC_MAXY;
        }

        if (p[2] < mMin[2])
        {
            ret |= CC_MINZ;
        }
        else if (p[2] > mMax[2])
        {
            ret |= CC_MAXZ;
        }

        return ret;
    }

    inline void clamp(const BoundsAABB& aabb)
    {
        if (mMin[0] < aabb.mMin[0])
            mMin[0] = aabb.mMin[0];
        if (mMin[1] < aabb.mMin[1])
            mMin[1] = aabb.mMin[1];
        if (mMin[2] < aabb.mMin[2])
            mMin[2] = aabb.mMin[2];
        if (mMax[0] > aabb.mMax[0])
            mMax[0] = aabb.mMax[0];
        if (mMax[1] > aabb.mMax[1])
            mMax[1] = aabb.mMax[1];
        if (mMax[2] > aabb.mMax[2])
            mMax[2] = aabb.mMax[2];
    }

    float mMin[3];
    float mMax[3];
};

class NodeAABB;

class NodeAABB
{
public:
    NodeAABB(void)
    {
        mLeft              = NULL;
        mRight             = NULL;
        mLeafTriangleIndex = TRI_EOF;
    }

    NodeAABB(unsigned int vcount, const float* vertices, unsigned int tcount, unsigned int* indices,
             unsigned int               maxDepth,    // Maximum recursion depth for the triangle mesh.
             unsigned int               minLeafSize, // minimum triangles to treat as a 'leaf' node.
             float                      minAxisSize,
             NodeInterface*             callback,
             std::vector<unsigned int>& leafTriangles) // once a particular axis is less than this size, stop sub-dividing.

    {
        mLeft              = NULL;
        mRight             = NULL;
        mLeafTriangleIndex = TRI_EOF;
        std::vector<unsigned int> triangles;
        triangles.reserve(tcount);
        for (unsigned int i = 0; i < tcount; i++)
        {
            triangles.push_back(i);
        }
        mBounds.setMin(vertices);
        mBounds.setMax(vertices);
        const float* vtx = vertices + 3;
        for (unsigned int i = 1; i < vcount; i++)
        {
            mBounds.include(vtx);
            vtx += 3;
        }
        split(triangles, vcount, vertices, tcount, indices, 0, maxDepth, minLeafSize, minAxisSize, callback, leafTriangles);
    }

    NodeAABB(const BoundsAABB& aabb)
    : mBounds(aabb)
    {
        mLeft              = NULL;
        mRight             = NULL;
        mLeafTriangleIndex = TRI_EOF;
    }

    ~NodeAABB(void)
    {
    }

    // here is where we split the mesh..
    void split(const std::vector<unsigned int>& triangles,
               unsigned int                     vcount,
               const float*                     vertices,
               unsigned int                     tcount,
               const unsigned int*              indices,
               unsigned int                     depth,
               unsigned int                     maxDepth,    // Maximum recursion depth for the triangle mesh.
               unsigned int                     minLeafSize, // minimum triangles to treat as a 'leaf' node.
               float                            minAxisSize,
               NodeInterface*                   callback,
               std::vector<unsigned int>&       leafTriangles) // once a particular axis is less than this size, stop sub-dividing.

    {
        // Find the longest axis of the bounding volume of this node
        float dx = mBounds.mMax[0] - mBounds.mMin[0];
        float dy = mBounds.mMax[1] - mBounds.mMin[1];
        float dz = mBounds.mMax[2] - mBounds.mMin[2];

        AxisAABB axis  = AABB_XAXIS;
        float    laxis = dx;

        if (dy > dx)
        {
            axis  = AABB_YAXIS;
            laxis = dy;
        }

        if (dz > dx && dz > dy)
        {
            axis  = AABB_ZAXIS;
            laxis = dz;
        }

        unsigned int count = triangles.size();

        // if the number of triangles is less than the minimum allowed for a leaf node or...
        // we have reached the maximum recursion depth or..
        // the width of the longest axis is less than the minimum axis size then...
        // we create the leaf node and copy the triangles into the leaf node triangle array.
        if (count < minLeafSize || depth >= maxDepth || laxis < minAxisSize)
        {
            // Copy the triangle indices into the leaf triangles array
            mLeafTriangleIndex = leafTriangles.size(); // assign the array start location for these leaf triangles.
            leafTriangles.push_back(count);
            for (std::vector<unsigned int>::const_iterator i = triangles.begin(); i != triangles.end(); ++i)
            {
                unsigned int tri = *i;
                leafTriangles.push_back(tri);
            }
        }
        else
        {
            float center[3];
            mBounds.getCenter(center);
            BoundsAABB b1, b2;
            splitRect(axis, mBounds, b1, b2, center);

            // Compute two bounding boxes based upon the split of the longest axis

            BoundsAABB leftBounds, rightBounds;

            std::vector<unsigned int> leftTriangles;
            std::vector<unsigned int> rightTriangles;

            // Create two arrays; one of all triangles which intersect the 'left' half of the bounding volume node
            // and another array that includes all triangles which intersect the 'right' half of the bounding volume node.
            for (std::vector<unsigned int>::const_iterator i = triangles.begin(); i != triangles.end(); ++i)
            {
                unsigned int tri = (*i);

                {
                    unsigned int i1 = indices[tri * 3 + 0];
                    unsigned int i2 = indices[tri * 3 + 1];
                    unsigned int i3 = indices[tri * 3 + 2];

                    const float* p1 = &vertices[i1 * 3];
                    const float* p2 = &vertices[i2 * 3];
                    const float* p3 = &vertices[i3 * 3];

                    unsigned int addCount = 0;
                    unsigned int orCode   = 0xFFFFFFFF;
                    if (b1.containsTriangleExact(p1, p2, p3, orCode))
                    {
                        addCount++;
                        if (leftTriangles.empty())
                        {
                            leftBounds.setMin(p1);
                            leftBounds.setMax(p1);
                        }
                        leftBounds.include(p1);
                        leftBounds.include(p2);
                        leftBounds.include(p3);
                        leftTriangles.push_back(tri); // Add this triangle to the 'left triangles' array and revise the left triangles bounding volume
                    }
                    // if the orCode is zero; meaning the triangle was fully self-contiained int he left bounding box; then we don't need to test against the right
                    if (orCode && b2.containsTriangleExact(p1, p2, p3, orCode))
                    {
                        addCount++;
                        if (rightTriangles.empty())
                        {
                            rightBounds.setMin(p1);
                            rightBounds.setMax(p1);
                        }
                        rightBounds.include(p1);
                        rightBounds.include(p2);
                        rightBounds.include(p3);
                        rightTriangles.push_back(tri); // Add this triangle to the 'right triangles' array and revise the right triangles bounding volume.
                    }
                    assert(addCount);
                }
            }

            if (!leftTriangles.empty()) // If there are triangles in the left half then...
            {
                leftBounds.clamp(b1);             // we have to clamp the bounding volume so it stays inside the parent volume.
                mLeft = callback->getNode();      // get a new AABB node
                new (mLeft) NodeAABB(leftBounds); // initialize it to default constructor values.
                // Then recursively split this node.
                mLeft->split(leftTriangles, vcount, vertices, tcount, indices, depth + 1, maxDepth, minLeafSize, minAxisSize, callback, leafTriangles);
            }

            if (!rightTriangles.empty()) // If there are triangles in the right half then..
            {
                rightBounds.clamp(b2);        // clamps the bounding volume so it stays restricted to the size of the parent volume.
                mRight = callback->getNode(); // allocate and default initialize a new node
                new (mRight) NodeAABB(rightBounds);
                // Recursively split this node.
                mRight->split(rightTriangles, vcount, vertices, tcount, indices, depth + 1, maxDepth, minLeafSize, minAxisSize, callback, leafTriangles);
            }
        }
    }

    void splitRect(AxisAABB axis, const BoundsAABB& source, BoundsAABB& b1, BoundsAABB& b2, const float* midpoint)
    {
        switch (axis)
        {
            case AABB_XAXIS:
            {
                b1.setMin(source.mMin);
                b1.setMax(midpoint[0], source.mMax[1], source.mMax[2]);

                b2.setMin(midpoint[0], source.mMin[1], source.mMin[2]);
                b2.setMax(source.mMax);
            }
            break;
            case AABB_YAXIS:
            {
                b1.setMin(source.mMin);
                b1.setMax(source.mMax[0], midpoint[1], source.mMax[2]);

                b2.setMin(source.mMin[0], midpoint[1], source.mMin[2]);
                b2.setMax(source.mMax);
            }
            break;
            case AABB_ZAXIS:
            {
                b1.setMin(source.mMin);
                b1.setMax(source.mMax[0], source.mMax[1], midpoint[2]);

                b2.setMin(source.mMin[0], source.mMin[1], midpoint[2]);
                b2.setMax(source.mMax);
            }
            break;
        }
    }

    virtual void raycast(bool&                            hit,
                         const float*                     from,
                         const float*                     to,
                         const float*                     dir,
                         float*                           hitLocation,
                         float*                           hitNormal,
                         float*                           hitDistance,
                         const float*                     vertices,
                         const unsigned int*              indices,
                         float&                           nearestDistance,
                         NodeInterface*                   callback,
                         unsigned int*                    raycastTriangles,
                         unsigned int                     raycastFrame,
                         const std::vector<unsigned int>& leafTriangles,
                         unsigned int&                    nearestTriIndex)
    {
        float sect[3];
        float nd = nearestDistance;
        if (!intersectLineSegmentAABB(mBounds.mMin, mBounds.mMax, from, dir, nd, sect))
        {
            return;
        }
        if (mLeafTriangleIndex != TRI_EOF)
        {
            const unsigned int* scan  = &leafTriangles[mLeafTriangleIndex];
            unsigned int        count = *scan++;
            for (unsigned int i = 0; i < count; i++)
            {
                unsigned int tri = *scan++;
                if (raycastTriangles[tri] != raycastFrame)
                {
                    raycastTriangles[tri] = raycastFrame;
                    unsigned int i1       = indices[tri * 3 + 0];
                    unsigned int i2       = indices[tri * 3 + 1];
                    unsigned int i3       = indices[tri * 3 + 2];

                    const float* p1 = &vertices[i1 * 3];
                    const float* p2 = &vertices[i2 * 3];
                    const float* p3 = &vertices[i3 * 3];

                    float t;
                    if (rayIntersectsTriangle(from, dir, p1, p2, p3, t))
                    {
                        bool accept = false;
                        if (t == nearestDistance && tri < nearestTriIndex)
                        {
                            accept = true;
                        }
                        if (t < nearestDistance || accept)
                        {
                            nearestDistance = t;
                            if (hitLocation)
                            {
                                hitLocation[0] = from[0] + dir[0] * t;
                                hitLocation[1] = from[1] + dir[1] * t;
                                hitLocation[2] = from[2] + dir[2] * t;
                            }
                            if (hitNormal)
                            {
                                callback->getFaceNormal(tri, hitNormal);
                            }
                            if (hitDistance)
                            {
                                *hitDistance = t;
                            }
                            nearestTriIndex = tri;
                            hit             = true;
                        }
                    }
                }
            }
        }
        else
        {
            if (mLeft)
            {
                mLeft->raycast(hit, from, to, dir, hitLocation, hitNormal, hitDistance, vertices, indices, nearestDistance, callback, raycastTriangles, raycastFrame, leafTriangles, nearestTriIndex);
            }
            if (mRight)
            {
                mRight->raycast(hit, from, to, dir, hitLocation, hitNormal, hitDistance, vertices, indices, nearestDistance, callback, raycastTriangles, raycastFrame, leafTriangles, nearestTriIndex);
            }
        }
    }

    NodeAABB*    mLeft;              // left node
    NodeAABB*    mRight;             // right node
    BoundsAABB   mBounds;            // bounding volume of node
    unsigned int mLeafTriangleIndex; // if it is a leaf node; then these are the triangle indices.
};

RaycastMesh::RaycastMesh(unsigned int vcount, const float* vertices, unsigned int tcount, const unsigned int* indices, unsigned int maxDepth, unsigned int minLeafSize, float minAxisSize)
{
    mRaycastFrame = 0;

    if (maxDepth < 2)
    {
        maxDepth = 2;
    }

    if (maxDepth > 15)
    {
        maxDepth = 15;
    }
    unsigned int pow2Table[16] = { 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 65536 };
    mMaxNodeCount              = 0;
    for (unsigned int i = 0; i <= maxDepth; i++)
    {
        mMaxNodeCount += pow2Table[i];
    }
    mNodes     = new NodeAABB[mMaxNodeCount];
    mNodeCount = 0;
    mVcount    = vcount;
    mVertices  = (float*)::malloc(sizeof(float) * 3 * vcount);
    memcpy(mVertices, vertices, sizeof(float) * 3 * vcount);
    mTcount  = tcount;
    mIndices = (unsigned int*)::malloc(sizeof(unsigned int) * tcount * 3);
    memcpy(mIndices, indices, sizeof(unsigned int) * tcount * 3);
    mRaycastTriangles = (unsigned int*)::malloc(tcount * sizeof(unsigned int));
    memset(mRaycastTriangles, 0, tcount * sizeof(unsigned int));
    mRoot        = getNode();
    mFaceNormals = NULL;
    new (mRoot) NodeAABB(mVcount, mVertices, mTcount, mIndices, maxDepth, minLeafSize, minAxisSize, this, mLeafTriangles);
}

RaycastMesh::~RaycastMesh(void)
{
    delete[] mNodes;
    ::free(mVertices);
    ::free(mIndices);
    ::free(mFaceNormals);
    ::free(mRaycastTriangles);
}

bool RaycastMesh::raycast(const float* from, const float* to, float* hitLocation, float* hitNormal, float* hitDistance)
{
    bool ret = false;

    float dir[3];
    dir[0]         = to[0] - from[0];
    dir[1]         = to[1] - from[1];
    dir[2]         = to[2] - from[2];
    float distance = sqrtf(dir[0] * dir[0] + dir[1] * dir[1] + dir[2] * dir[2]);
    if (distance < 0.0000000001f)
        return false;
    float recipDistance = 1.0f / distance;
    dir[0] *= recipDistance;
    dir[1] *= recipDistance;
    dir[2] *= recipDistance;
    mRaycastFrame++;
    unsigned int nearestTriIndex = TRI_EOF;
    mRoot->raycast(ret, from, to, dir, hitLocation, hitNormal, hitDistance, mVertices, mIndices, distance, this, mRaycastTriangles, mRaycastFrame, mLeafTriangles, nearestTriIndex);
    return ret;
}

const float* RaycastMesh::getBoundMin(void) const // return the minimum bounding box
{
    return mRoot->mBounds.mMin;
}

const float* RaycastMesh::getBoundMax(void) const // return the maximum bounding box.
{
    return mRoot->mBounds.mMax;
}

NodeAABB* RaycastMesh::getNode(void)
{
    assert(mNodeCount < mMaxNodeCount);
    NodeAABB* ret = &mNodes[mNodeCount];
    mNodeCount++;
    return ret;
}

void RaycastMesh::getFaceNormal(unsigned int tri, float* faceNormal)
{
    if (mFaceNormals == NULL)
    {
        mFaceNormals = (float*)::malloc(sizeof(float) * 3 * mTcount);
        for (unsigned int i = 0; i < mTcount; i++)
        {
            unsigned int i1   = mIndices[i * 3 + 0];
            unsigned int i2   = mIndices[i * 3 + 1];
            unsigned int i3   = mIndices[i * 3 + 2];
            const float* p1   = &mVertices[i1 * 3];
            const float* p2   = &mVertices[i2 * 3];
            const float* p3   = &mVertices[i3 * 3];
            float*       dest = &mFaceNormals[i * 3];
            computePlane(p3, p2, p1, dest);
        }
    }
    const float* src = &mFaceNormals[tri * 3];
    faceNormal[0]    = src[0];
    faceNormal[1]    = src[1];
    faceNormal[2]    = src[2];
}

bool RaycastMesh::bruteForceRaycast(const float* from, const float* to, float* hitLocation, float* hitNormal, float* hitDistance)
{
    bool ret = false;

    float dir[3];

    dir[0] = to[0] - from[0];
    dir[1] = to[1] - from[1];
    dir[2] = to[2] - from[2];

    float distance = sqrtf(dir[0] * dir[0] + dir[1] * dir[1] + dir[2] * dir[2]);
    if (distance < 0.0000000001f)
        return false;

    float recipDistance = 1.0f / distance;
    dir[0] *= recipDistance;
    dir[1] *= recipDistance;
    dir[2] *= recipDistance;
    const unsigned int* indices         = mIndices;
    const float*        vertices        = mVertices;
    float               nearestDistance = distance;

    for (unsigned int tri = 0; tri < mTcount; tri++)
    {
        unsigned int i1 = indices[tri * 3 + 0];
        unsigned int i2 = indices[tri * 3 + 1];
        unsigned int i3 = indices[tri * 3 + 2];

        const float* p1 = &vertices[i1 * 3];
        const float* p2 = &vertices[i2 * 3];
        const float* p3 = &vertices[i3 * 3];

        float t;
        if (rayIntersectsTriangle(from, dir, p1, p2, p3, t))
        {
            if (t < nearestDistance)
            {
                nearestDistance = t;
                if (hitLocation)
                {
                    hitLocation[0] = from[0] + dir[0] * t;
                    hitLocation[1] = from[1] + dir[1] * t;
                    hitLocation[2] = from[2] + dir[2] * t;
                }

                if (hitNormal)
                {
                    getFaceNormal(tri, hitNormal);
                }

                if (hitDistance)
                {
                    *hitDistance = t;
                }
                ret = true;
            }
        }
    }
    return ret;
}
