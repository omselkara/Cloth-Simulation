# Cloth Simulation

A realistic cloth simulation implemented in Processing using Verlet integration and constraint-based physics. This interactive simulation demonstrates the behavior of a deformable cloth mesh that responds to gravity and user interaction.

## Features

- **Real-time Physics Simulation**: Uses Verlet integration for realistic cloth movement
- **Interactive Tearing**: Click and drag across the cloth to tear it apart
- **Constraint-based Physics**: Implements distance constraints between points to maintain cloth structure
- **Automatic Rupture**: Cloth tears when stretched beyond its elastic limit
- **Pinned Points**: Top row of the cloth is anchored, allowing it to hang naturally
- **Smooth Rendering**: 100 FPS target with smooth visual updates

## Demo

The simulation creates a 100x100 grid of interconnected points that behave like a piece of cloth. The cloth hangs from fixed points at the top and responds to gravity. Users can interact with the simulation by clicking and dragging to cut through the cloth.

## Technical Details

### Physics Engine

The simulation uses several physics concepts:

- **Verlet Integration**: Position-based dynamics for stable and efficient simulation
- **Distance Constraints**: Points are connected by "sticks" that maintain specific lengths
- **Iterative Solver**: 10 iterations per frame to resolve constraints and maintain cloth structure
- **Gravity**: Constant downward force applied to all non-pinned points
- **Elastic Rupture**: Sticks break when stretched to 200% of their original length

### Code Structure

- `Cloth_Simulation.pde`: Main sketch file containing setup, draw loop, and initialization
- `Physics.pde`: Contains physics classes and simulation logic
  - `Point` class: Represents cloth vertices with position, velocity, and pinned state
  - `Stick` class: Represents constraints between points (cloth fibers)
  - Helper functions for physics calculations and collision detection

### Parameters

Key simulation parameters that can be adjusted:

```processing
float gravity = 8F;        // Gravity strength
float fps = 100;           // Target frame rate
int col = 100;             // Number of columns in cloth grid
int row = 100;             // Number of rows in cloth grid
int iter = 10;             // Constraint solver iterations
```

## Requirements

- [Processing](https://processing.org/) 3.0 or higher
- Processing's P3D renderer (included by default)

## Installation

1. Download and install Processing from [processing.org](https://processing.org/download)
2. Clone this repository:
   ```bash
   git clone https://github.com/omselkara/Cloth-Simulation.git
   ```
3. Open `Cloth_Simulation.pde` in Processing
4. Click the "Run" button or press Ctrl+R (Cmd+R on Mac)

## Usage

### Controls

- **Mouse Click + Drag**: Cut through the cloth by dragging the mouse across it
- The simulation runs automatically once started
- Close the window to stop the simulation

### Interaction

The cloth responds to mouse interaction in real-time. When you click and drag across the cloth, any constraint (stick) that intersects with your mouse path will be removed, causing the cloth to tear. If enough constraints are removed, sections of the cloth may fall away entirely.

## How It Works

### Initialization

1. Creates a 100x100 grid of points
2. Connects adjacent points with distance constraints (sticks)
3. Pins the top row of points so they remain fixed
4. Each point has horizontal and vertical connections to its neighbors

### Simulation Loop

Each frame performs the following steps:

1. **Movement**: Update all point positions using Verlet integration
   - Apply gravity
   - Update position based on previous position (velocity is implicit)
2. **Constraint Resolution**: Iterate multiple times to satisfy distance constraints
   - Calculate distance between connected points
   - Adjust positions to maintain correct distances
   - Check for rupture (constraints stretched too far)
3. **Rendering**: Draw all sticks and points
4. **User Interaction**: Check for mouse collisions and remove intersected sticks

### Physics Implementation

**Verlet Integration:**
```processing
x += x - px;           // Update position
y += y - py;
y += gravity * dt;     // Apply gravity
px = x;                // Store previous position
py = y;
```

**Distance Constraints:**
```processing
float distance = dist(p1, p2);
float cx = (p1.x + p2.x) / 2;     // Center point
float cy = (p1.y + p2.y) / 2;
// Move points apart or together to maintain distance
```

## Customization

You can modify the simulation by adjusting various parameters in `Cloth_Simulation.pde`:

- **Change cloth size**: Modify `col` and `row` values
- **Adjust gravity**: Change the `gravity` value
- **Change resolution**: Modify `iter` for more or fewer constraint iterations
- **Adjust point visibility**: Change `radius` to show/hide individual points
- **Modify colors**: Change the `stroke()` and `fill()` colors in the show methods

## Performance

The simulation is optimized for real-time performance:

- Runs at 100 FPS on modern hardware
- Handles 10,000 points and ~20,000 constraints
- Uses efficient distance calculations
- Iterative constraint solver balances accuracy and performance

## Future Enhancements

Possible improvements and features:

- Add wind forces for more dynamic movement
- Implement collision with other objects
- Add different cloth materials with varying elasticity
- Include 3D depth for more realistic draping
- Add mouse interaction for pinning/unpinning points
- Implement cloth self-collision
- Add texture mapping for visual realism

## Contributing

Contributions are welcome! Feel free to:

- Report bugs
- Suggest new features
- Submit pull requests
- Improve documentation

## License

This project is open source and available for educational and personal use.

## Credits

Developed using Processing framework. Implements physics concepts from real-time cloth simulation research.

## Contact

For questions or feedback, please open an issue on the GitHub repository.

---

**Note**: This simulation is designed for educational purposes to demonstrate physics simulation techniques, particularly Verlet integration and constraint-based dynamics.
