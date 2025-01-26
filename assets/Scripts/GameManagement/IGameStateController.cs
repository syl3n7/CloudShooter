public enum GameManager
{
    Idle,
    Playing,
    Paused,
    Dead
}
public interface IGameStateController
{
    public abstract void Idle();
    public abstract void Playing();
    public abstract void Paused();
    public abstract void Dead();
}
