public enum GameManager
{
    Idle,
    Playing,
    Dead
}
public interface IGameStateController
{
    public abstract void Idle();
    public abstract void Playing();
    public abstract void Dead();
}
