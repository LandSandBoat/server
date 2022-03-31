#ifndef RAYCAST_MESH_H
#define RAYCAST_MESH_H

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

#include <vector>

class NodeAABB;

class NodeInterface
{
public:
    virtual NodeAABB* getNode(void)                                      = 0;
    virtual void      getFaceNormal(unsigned int tri, float* faceNormal) = 0;
};

class RaycastMesh : public NodeInterface
{
public:
    RaycastMesh(unsigned int        vcount,            // The number of vertices in the source triangle mesh
                const float*        vertices,          // The array of vertex positions in the format x1,y1,z1..x2,y2,z2.. etc.
                unsigned int        tcount,            // The number of triangles in the source triangle mesh
                const unsigned int* indices,           // The triangle indices in the format of i1,i2,i3 ... i4,i5,i6, ...
                unsigned int        maxDepth    = 15,  // Maximum recursion depth for the triangle mesh.
                unsigned int        minLeafSize = 4,   // minimum triangles to treat as a 'leaf' node.
                float               minAxisSize = 0.1f // once a particular axis is less than this size, stop sub-dividing.
    );

    virtual ~RaycastMesh();

    bool raycast(const float* from, const float* to, float* hitLocation, float* hitNormal, float* hitDistance);
    bool bruteForceRaycast(const float* from, const float* to, float* hitLocation, float* hitNormal, float* hitDistance);

    const float* getBoundMin(void) const; // return the minimum bounding box
    const float* getBoundMax(void) const; // return the maximum bounding box.

    NodeAABB* getNode(void);
    void      getFaceNormal(unsigned int tri, float* faceNormal);

    unsigned int              mRaycastFrame;
    unsigned int*             mRaycastTriangles;
    unsigned int              mVcount;
    float*                    mVertices;
    float*                    mFaceNormals;
    unsigned int              mTcount;
    unsigned int*             mIndices;
    NodeAABB*                 mRoot;
    unsigned int              mNodeCount;
    unsigned int              mMaxNodeCount;
    NodeAABB*                 mNodes;
    std::vector<unsigned int> mLeafTriangles;
};

#endif // RAYCAST_MESH_H
