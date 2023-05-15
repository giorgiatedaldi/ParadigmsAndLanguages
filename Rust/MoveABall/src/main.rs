// const ARENA_W: i32 = 480;
// const ARENA_H: i32 = 360;
// const BALL_W: i32 = 20;
// const BALL_H: i32 = 20;

// struct Ball {
//     x: i32,
//     y: i32,
//     dx: i32,
//     dy: i32,
// }

// fn move_ball(ball: &mut Ball) {
//     if !(0 <= ball.x + ball.dx && ball.x + ball.dx <= ARENA_W - BALL_W) {
//         ball.dx = -ball.dx;
//     }
//     if !(0 <= ball.y + ball.dy && ball.y + ball.dy <= ARENA_H - BALL_H) {
//         ball.dy = -ball.dy;
//     }
//     ball.x += ball.dx;
//     ball.y += ball.dy;
// }

// fn main() {
//     let mut ball1 = Ball { x: 140, y: 180, dx: 5, dy: 5 };

//     move_ball(&mut ball1);

//     println!("b1 @ ({}, {})", ball1.x, ball1.y);

// }


const ARENA_W: i32 = 480;
const ARENA_H: i32 = 360;
const BALL_W: i32 = 20;
const BALL_H: i32 = 20;

struct Ball {
    x: i32,
    y: i32,
    dx: i32,
    dy: i32,
}

fn move_ball(mut ball: Ball) -> Ball {
    if !(0 <= ball.x + ball.dx && ball.x + ball.dx <= ARENA_W - BALL_W) {
        ball.dx = -ball.dx;
    }
    if !(0 <= ball.y + ball.dy && ball.y + ball.dy <= ARENA_H - BALL_H) {
        ball.dy = -ball.dy;
    }
    ball.x += ball.dx;
    ball.y += ball.dy;
    ball
}

fn main() {
    let mut ball = Ball { x: 140, y: 180, dx: 5, dy: 5 };
    ball = move_ball(ball);
    println!("Ball position: ({}, {})", ball.x, ball.y);
}

