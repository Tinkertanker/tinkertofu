//
//  TofuScene
//  Tinkertofu
//
//  Created by Yuan Yuchuan / Zhang Hongyi / Soon Yinjie 5/7/2015.
//  Copyright (c) 2015 Tinkercademy. All rights reserved.
//

import SpriteKit

public class TofuScene: SKScene {
    
    var tofu:SKSpriteNode = SKSpriteNode(imageNamed: "tofu", normalMapped: false)
    let squareSize:Int=50
    var moveSequence = [SKAction]()
    var rotation:Double = 0.0
    var pickups=[SKSpriteNode]();
    var walls=[SKSpriteNode]();
    var xcord = 0;
    var ycord = 0;
    var dead = false;
    var score = 0;
    var won = true;
    var maze = [
        /*Start*/[0,1,0,0,0,0,0,1,1,1,1,1,0,0,0],//bottom right
        [0,1,0,1,1,1,1,1,0,0,0,0,1,0,0],
        [0,1,0,1,0,0,0,1,0,1,1,1,1,0,0], // 0 denotes space, 1 denotes wall
        [0,1,1,1,0,1,1,1,0,1,1,1,1,1,0], // 2 denotes pickup
        [0,0,0,0,0,1,0,0,0,0,0,0,0,3,0], // 3 denotes goal
        [1,1,1,1,0,1,1,1,1,0,1,1,1,1,0],
        [0,0,0,1,0,0,0,0,0,0,1,0,0,0,0],
        [0,0,0,1,1,1,1,0,1,1,1,0,0,0,0],
        [0,0,0,0,0,0,1,1,1,0,0,0,0,0,0],//top right
    ]
    
    override public func didMoveToView(view : SKView) {
        
        scaleMode = .ResizeFill
        
        tofu.size = CGSizeMake(CGFloat(squareSize),CGFloat(squareSize));
        tofu.position = positionAtGrid(0 , y:0)
        //        tofu.runAction(SKAction.repeatActionForever(SKAction.rotateByAngle(6, duration: 2)))
        //Generate terrain, assuming that it's rectangular
        var i=0;
        var j=0;
        for row in maze {
            
            j=0;
            for cell in row{
                if(cell != 0){
                    switch(cell){
                    case 1:
                        walls.append(SKSpriteNode(color: SKColor.redColor(), size: CGSizeMake(CGFloat(squareSize),CGFloat(squareSize))));
                        walls[walls.count-1].position=positionAtGrid(j, y: i)
                        addChild(walls[walls.count-1])
                        break
                    case 2:
                        pickups.append(SKSpriteNode(imageNamed:"cherry.png",normalMapped:false));
                        pickups[pickups.count-1].size=CGSizeMake(CGFloat(squareSize),CGFloat(squareSize))
                        pickups[pickups.count-1].position=positionAtGrid(j, y: i)
                        addChild(pickups[pickups.count-1])
                        break
                    case 3:
                        walls.append(SKSpriteNode(color: SKColor.yellowColor(), size: CGSizeMake(CGFloat(squareSize),CGFloat(squareSize))));
                        walls[walls.count-1].position=positionAtGrid(j, y: i)
                        addChild(walls[walls.count-1])
                        break
                    default:
                        
                        break
                    }
                }
                j++;
            }
            i++;
        }
        //last so it's on top of everything else
        addChild(tofu)
        
    }
    
    public func moveForward()->String{
        if(!dead){
            var dx=sin(rotation)*Double(squareSize)*Double(-1)
            var dy=cos(rotation)*Double(squareSize)
            xcord-=Int(sin(rotation))
            ycord+=Int(cos(rotation))
            moveSequence.append(SKAction.moveBy(CGVector(dx: dx, dy: dy), duration: 0.5))
        }
        return "Okay, I'll move forward next."
    }
    
    public func turnRight()->String{
        if(!dead){
            rotation=rotation-M_PI_2
            moveSequence.append(SKAction.rotateToAngle(CGFloat(rotation), duration: 0.5))
        }
        return "Okay, I'll turn right next."
    }
    
    public func turnLeft()->String{
        /*if(!dead){
        rotation=rotation+M_PI_2
        moveSequence.append(SKAction.rotateToAngle(CGFloat(rotation), duration: 0.5))
        }*/
        return "Sorry, I can't turn left."
    }
    
    //    public func moveRight(){
    //        moveSequence.append(SKAction.moveBy(CGVector(dx: squareSize, dy: 0), duration: 0.5))
    //    }
    
    public func move()->String{
        doMove(0)
        return "Moving~"
    }
    
    private func doMove(step:Int){
        if(step>=moveSequence.count){
            print("Done! I picked up ")
            print(score)
            print("  cherries!")
        }
        else{
            print(self.roundPosition(self.tofu.position))
            var action=self.moveSequence[step]
            tofu.runAction(action,completion:{
                var mazeValue = self.mazeValueAtPosition(self.tofu.position)
                if(mazeValue==1){
                    print("I died!")
                    self.dead=true
                    self.tofu.runAction(SKAction.repeatActionForever(SKAction.rotateByAngle(6,duration: 2)))
                }
                else if(mazeValue==2){
                    for pickup in self.pickups {
                        print(pickup.position)
                        print(self.roundPosition(self.tofu.position))
                        if(pickup.position==self.roundPosition(self.tofu.position)){
                            if(!pickup.hidden){
                                print(self.score)
                                self.score++
                                pickup.hidden=true;
                            }
                        }
                    }
                    self.doMove(step+1)
                }
                else if(mazeValue==3){
                    print("I'm done!")
                }
                else{
                    self.doMove(step+1)
                }
            })
        }
    }
    private func positionAtGrid(x:Int,y:Int)->CGPoint{
        return CGPointMake(CGFloat(60+x*squareSize),CGFloat(60+y*squareSize))
    }
    private func mazeValueAtPosition(position:CGPoint)->Int{
        var xcord=round((position.x-60)/CGFloat(squareSize))
        var ycord=round((position.y-60)/CGFloat(squareSize))
        return maze[Int(ycord)][Int(xcord)]
    }
    private func roundPosition(position:CGPoint) -> CGPoint{
        return CGPointMake(CGFloat(round(position.x*10)/10), CGFloat(round(position.y*10)/10))
    }
    func getScore()->Int{
        return score;
    }

    
}
